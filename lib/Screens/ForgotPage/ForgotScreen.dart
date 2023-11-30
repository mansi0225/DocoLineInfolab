import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Widgets/textFromField.dart';
import '../VerifyOTPPage/VerifyOTPPage.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool _isLoading = false;
  //ForgotPasswordApi forgotPasswordApi;
  TextEditingController mobileController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  String? mobile;
  String? userName;
  String? userId;
  //late ForgotApi forgotApi;


  // forgotPassword(String email) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // Map data = {
  //   //   'email': email,
  //   //   'password': "password",
  //   // };
  //   // var body = json.encode(data);
  //   final response = await http.post(
  //       Uri.parse(HXNConfig.hxn_app_url+"api/users/forgetpassword/emailId?emailId=" + email),
  //       headers: {'Content-Type': 'application/json'},
  //   );
  //   if(response.statusCode == 200) {
  //     forgotApi = new ForgotApi.fromJsonMap(json.decode(response.body.toString()));
  //     if(!forgotApi.success) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       AlertService().showAlert(
  //         context: context,
  //         message: forgotApi.message,
  //         type: AlertType.error,
  //       );
  //
  //       // Fluttertoast.showToast(
  //       //     msg: "Successfully Login",
  //       //     toastLength: Toast.LENGTH_LONG,
  //       //     gravity: ToastGravity.BOTTOM,
  //       //     timeInSecForIosWeb: 2
  //       // );
  //
  //     }
  //     else{
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print(response.body);
  //       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //       //     builder: (BuildContext context) => HomePage()), (
  //       //     Route<dynamic> route) => false);
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP(userId: forgotApi.id.toString(),pageName: "Forgot",otp: forgotApi.userOTP,phoneNumber: email,)));
  //       //Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(userId: "1")));
  //       AlertService().showAlert(
  //         context: context,
  //         message: forgotApi.message,
  //         type: AlertType.success,
  //       );
  //
  //       // Fluttertoast.showToast(
  //       //     msg: "Either email or password is wrong....",
  //       //     toastLength: Toast.LENGTH_LONG,
  //       //     gravity: ToastGravity.BOTTOM,
  //       //     timeInSecForIosWeb: 2
  //       // );
  //       print(response.body);
  //     }
  //   }else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print(response.body);
  //   }
  //
  // }

  @override
  void initState() {
    super.initState();
  }

//  forgotPassword(String mobile) async {
//    int mobileNumber = int.parse(mobile);
////    mobile = mobileController.text;
//    var response = await http.get(PsConfig.ps_app_url+"Api/CustomerApi/forgotPassword/$mobileNumber");
//    forgotPasswordApi = new ForgotPasswordApi.fromJsonMap(json.decode(response.body.toString()));
//    if(response.statusCode == 200) {
//      if (forgotPasswordApi.Status=="Success") {
//        setState(() {
//          _isLoading = false;
//        });
//        //     sharedPreferences.setString("userId",userLoginAPi.userData.user_id);
//        print(response.body);
//        userId = forgotPasswordApi.forgotPassword.user_id;
//        userName = forgotPasswordApi.forgotPassword.fname;
//        Fluttertoast.showToast(
//            msg: forgotPasswordApi.Message,
//            toastLength: Toast.LENGTH_LONG,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 2
//        );
//        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyForgotPasswordOTP(userId: userId)));
//      }else{
//        setState(() {
//          _isLoading = false;
//        });
//        Fluttertoast.showToast(
//            msg: forgotPasswordApi.Message,
//            toastLength: Toast.LENGTH_LONG,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 2
//        );
//        print(response.body);
//      }
//    }else {
//      setState(() {
//        _isLoading = false;
//      });
//      print(response.body);
//    }
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF08364B),
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios, color:Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor:  Color(0xFF08364B),
      ),
      body: Container(
        child: _isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : ListView(
          children: <Widget>[
            headerSection(),
            textSection()
          ],
        ),
      ),
    );
  }
  Container headerSection() {
    return Container(
        alignment: Alignment.center,
        child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 150,
                child: new Image.asset('assets/images/password.png'),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40,bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text('Forgot Password?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('We just need your Email address to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],),
              ),] ));
  }

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    // Container(
                    //   child: Row(
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.all(16),
                    //         child: Container(
                    //           width: 40,
                    //           height: 40,
                    //           child: new Image.asset('assets/images/mail.png'),
                    //         ),
                    //       ),
                    //       Text('Enter Your Email Address',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //             color: Colors.white70,
                    //             fontWeight: FontWeight.bold
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child : CustomTextField(
                        textEditingController: mobileController,
                        errorMsg: 'Please enter Email Address',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.mail_outline,
                        obscureText: false,
                        hint: "Enter Email Address",
                      ),
                    ),
                    SizedBox(height: 40.0),
                    MaterialButton(
                      height: 55.0,
                      minWidth: MediaQuery.of(context).size.width/2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(24.0),
                              bottomLeft: Radius.circular(24.0),
                              bottomRight: Radius.circular(5.0))
                      ),
                      onPressed:(){

                        final form = formKey.currentState;
                        if (form!.validate()) {
                          // setState(() {
                          //   _isLoading = true;
                          // });
                          // forgotPassword(mobileController.text);
                         // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTP(userId: "1",pageName: "Forgot",otp: "1234",phoneNumber: "email",)));
                        }
                      },
                      child: Text('Submit'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      color: Color(0xFFF4CC1F),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),);
  }
}
