import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newdocolineproject/Screens/ForgotPage/resetdocnew.dart';
import 'package:newdocolineproject/Screens/ForgotPage/resetnew.dart';

import '../../Widgets/textFromField.dart';

class UserOtp extends StatefulWidget {
  const UserOtp({Key? key}) : super(key: key);

  @override
  State<UserOtp> createState() => _UserOtpState();
}

class _UserOtpState extends State<UserOtp> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ResetNew(),));
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