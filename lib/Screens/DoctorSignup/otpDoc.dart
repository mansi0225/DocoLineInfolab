import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import '../DoctorLoginScreen/DoctorLoginPage.dart';

class OtpDoc extends StatefulWidget {
  String name1;
  String email1;
  String password1;
  OtpDoc({Key? key,required this.name1,required this.email1,required this.password1}) : super(key: key);

  @override
  State<OtpDoc> createState() => _OtpDocState();
}

class _OtpDocState extends State<OtpDoc> {

  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  late CommonClass commonClass;
  bool _isLoading = false;
  void initState() {
    // TODO: implement initState
    super.initState();
// signUp(nameController.text, emailController.text, passwordController.text);
    //     myauth.setConfig(
    //         appEmail: "harshilribadiya@gmail.com",
    //         appName: "DocoLine",
    //         userEmail: emailController.text,
    //         otpLength: 6,
    //         otpType: OTPType.digitsOnly
    //     );
    //     if (await myauth.sendOTP() == true) {
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => OtpDoc(name1: nameController.text,email1: emailController.text,password1: passwordController.text,),));
    //       Fluttertoast.showToast(
    //           msg: "OTP has been sent",
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 2
    //       );
    //     } else {
    //       Fluttertoast.showToast(
    //           msg: "Oops, OTP send failed",
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 2
    //       );
    //     }
    //
    //   }
    // }
  }
  signUp(String name,email,password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'dname': name,
      'demail':email,
      'dpass': password,
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/doctor/dsingupinsert.php"), body: data);
    commonClass = new CommonClass.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!commonClass.error) {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => DoctorLoginPage()), (
            Route<dynamic> route) => false);
        print(response.body);
      }else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFF08364B),
        appBar: AppBar(
          title: Text("Forget Password"),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                        ),] )),

              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child : CustomTextField(
                              textEditingController: email,
                              errorMsg: 'Please enter Email Address',
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.mail_outline,
                              obscureText: false,
                              hint: "Enter Email Address",
                            ),
                          ),
                          SizedBox(height: 20.0,),
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
                            onPressed:() async{
                              myauth.setConfig(
                                  appEmail: "harshilribadiya@gmail.com",
                                  appName: "DocoLine",
                                  userEmail: email.text,
                                  otpLength: 6,
                                  otpType: OTPType.digitsOnly
                              );
                              if (await myauth.sendOTP() == true) {
                                Fluttertoast.showToast(
                                    msg: "OTP has been sent",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Oops, OTP send failed",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2
                                );
                              }

                            },
                            child: Text('Send Otp'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            color: Color(0xFFF4CC1F),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child : CustomTextField(
                              textEditingController: otp,
                              errorMsg: 'Please enter otp',
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.mail_outline,
                              obscureText: false,
                              hint: "Enter Otp",
                            ),
                          ),
                          SizedBox(height: 20.0,),
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
                            onPressed: () async {
                              if (await myauth.verifyOTP(otp: otp.text) == true) {
                                Fluttertoast.showToast(
                                    msg: "OTP is verified",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2
                                );
                                signUp(widget.name1,widget.email1,widget.password1);

                              } else {
                                Fluttertoast.showToast(
                                    msg: "Invalid OTP",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2
                                );
                              }
                            },
                            child: Text('Verify'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            color: Color(0xFFF4CC1F),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}