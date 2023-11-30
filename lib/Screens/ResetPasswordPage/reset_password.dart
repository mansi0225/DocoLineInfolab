import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:newdocolineproject/Screens/ChooseUserScreen/choice_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/textFromField.dart';

class ResetPassword extends StatefulWidget {

  final String userEmail;
//  final String userName;

  ResetPassword({required this.userEmail});

  @override
  _ResetPasswordState createState() => _ResetPasswordState(userEmail);
}

class _ResetPasswordState extends State<ResetPassword> {
  String userEmail;
//  String userName;
  _ResetPasswordState(this.userEmail);
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  TextEditingController resetPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  //ResetPassworrdApi resetPassworrdApi;
 // late CommonApi commonApi;

  // resetPassword(String  password) async {
  //   Map data = {
  //     "emailId": userEmail,
  //     "password": password
  //   };
  //   var body = json.encode(data);
  //   final response = await http.post(
  //       Uri.parse(HXNConfig.hxn_app_url+"api/users/resetpassword"),
  //       headers: {'Content-Type': 'application/json'},
  //       body: body
  //   );
  //   commonApi = CommonApi.fromJsonMap(json.decode(response.body.toString()));
  //   if (response.statusCode == 200) {
  //     if (commonApi.isSuccessful) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print(response.body);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
  //               (Route<dynamic> route) => false);
  //       AlertService().showAlert(
  //         context: context,
  //         message: commonApi.message,
  //         type: AlertType.success,
  //       );
  //     } else {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       AlertService().showAlert(
  //         context: context,
  //         message: commonApi.message,
  //         type: AlertType.error,
  //       );
  //       print(response.body);
  //     }
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     AlertService().showAlert(
  //       context: context,
  //       message: "Something Went Wrong",
  //       type: AlertType.success,
  //     );
  //     print(response.body);
  //   }
  // }

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
                    Text('Reset Your Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('Enter your New password to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                      ),
                    ),
//                    SizedBox(height: 20.0),
//                    Text('',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.bold
//                      ),
//                    ),
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
                // color: Color(0xFF032737),
                // shape: RoundedRectangleBorder(
                //   side: new BorderSide(color: Color(0xFF539cd4), width: 3.0),
                //   borderRadius:  BorderRadius.only(
                //       topLeft: Radius.circular(5.0),
                //       topRight: Radius.circular(36.0),
                //       bottomLeft: Radius.circular(36.0),
                //       bottomRight: Radius.circular(5.0)),
                // ),
                // elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child : CustomTextField(
                          textEditingController: resetPasswordController,
                          errorMsg: 'Please enter New Password',
                          keyboardType: TextInputType.visiblePassword,
                          icon: Icons.lock,
                          obscureText: false,
                          hint: "New Password",
                        ),
                      ),
                      SizedBox(height: 30.0),
                      // Container(
                      //   padding: EdgeInsets.only(left: 20, right: 20),
                      //   child : CustomTextField(
                      //     textEditingController: confirmPasswordController,
                      //     errorMsg: 'Please enter Confirm Password',
                      //     keyboardType: TextInputType.visiblePassword,
                      //     icon: Icons.password,
                      //     obscureText: false,
                      //     hint: "Confirm Password",
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              topRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(2.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.transparent.withOpacity(0.4),
                                blurRadius: 18,
                                offset: Offset(0, 7)),
                          ],
                        ),
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Confirm Password';
                            }
                            if (value != resetPasswordController.text) {
                              return "Password Does not match";
                            }
                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:Color(0xFF032737),
                            prefixIcon: Icon(Icons.password, color: Colors.white, size: 20),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                                color: Colors.white70
                            ),
                            errorStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: Color(0xFF539cd4),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xFF539cd4),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(5.0)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color:Color(0xFF539cd4),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      MaterialButton(
                        height: 55.0,
                        minWidth: MediaQuery.of(context).size.width/1.2,
                        shape: RoundedRectangleBorder(
                            borderRadius:  BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(24.0),
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(5.0))
                        ),
                        onPressed:_submit,
                        child: Text('Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
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

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => choice_login()),
              (Route<dynamic> route) => false);
     //  setState(() {
     //    _isLoading = true;
     //  });
     // resetPassword(resetPasswordController.text);
    }
  }

}
