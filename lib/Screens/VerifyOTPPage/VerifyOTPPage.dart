import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../ResetPasswordPage/reset_password.dart';

class VerifyOTP extends StatefulWidget {
  final String userId;
  final String pageName;
  final String otp;
  final String phoneNumber;

  VerifyOTP({required this.userId,required this.pageName,required this.otp,required this.phoneNumber});

  @override
  _VerifyOTPState createState() => _VerifyOTPState(userId,pageName,otp,phoneNumber);
}

class _VerifyOTPState extends State<VerifyOTP> {
  String userId;
  String pageName;
  String otp;
  String phoneNumber;
  _VerifyOTPState(this.userId,this.pageName,this.otp,this.phoneNumber);

  bool _isLoading = false;
  String? smsOTP;
  String currentText = "";
  bool hasError = false;
  String? deviceType;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  Future<void> _checkDevice() async {
    if (Platform.isAndroid) {
      deviceType = "android";
    } else if (Platform.isIOS) {
      deviceType = "iphone";
    }
  }

  @override
  void initState() {
    _checkDevice();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.done;
    super.dispose();
  }


  // fetchVerifyOTP(String otpCheck) async {
  //
  //   Map data = {
  //     "user_id":userId,
  //     "otp_check":otpCheck,
  //     "device_type":deviceType
  //   };
  //   var body = json.encode(data);
  //   final response = await http.post(
  //       Uri.parse(GateStopperConfig.gateStopper_app_url +"otpCheck"),
  //       headers: {'Content-Type': 'application/json'},
  //       body: body
  //   );
  //   otpCheckApi = new OtpCheckApi.fromJsonMap(json.decode(response.body.toString()));
  //
  //   if(response.statusCode == 200) {
  //
  //     if (otpCheckApi!.status=="success") {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       Fluttertoast.showToast(
  //           msg: otpCheckApi!.message,
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 2
  //       );
  //       // if(pageName=="Forgot"){
  //       //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //       //       builder: (BuildContext context) => ChangePasswordPage(userId: userId,)), (
  //       //       Route<dynamic> route) => false);
  //       // }else{
  //       //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //       //       builder: (BuildContext context) => LoginPage()), (
  //       //       Route<dynamic> route) => false);
  //       // }
  //       print(response.body);
  //     }
  //   }else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //         msg: otpCheckApi!.message,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 2
  //     );
  //     print(response.body);
  //   }
  //
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
        child:  _isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            //   otpSection()
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
                height: 200,
                child: new Image.asset('assets/images/forgotpassword.png'),
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40,bottom: 40),
                child: Column(
                  children: <Widget>[
                    Text('Verify OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Please enter 4 digits code sent to your mobile number',
                      //'Enter Your OTP send to Your Mobile Number to Verify it',
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
            child: Card(
              color: Color(0xFF032737),
              shape: RoundedRectangleBorder(
                side: new BorderSide(color: Color(0xFF539cd4), width: 3.0),
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0))
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.only(top: 16,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 8,left: 24,right: 24),
                        //  margin: EdgeInsets.only(left: screenWidth * 0.025),
                        child:PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 3) {
                              return "Fill all the fields";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            inactiveColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            selectedColor: Colors.white,
                            selectedFillColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeColor: Colors.white,
                            activeFillColor:
                            hasError ? Colors.red : Colors.white,
                          ),
                          textStyle: TextStyle(color: Colors.black87 ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onSubmitted: (text){
                            smsOTP = text;
                          },
                          onCompleted: (v) {
                            smsOTP = v;
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),

                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top:36),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("If you don’t receive the code? ", style: TextStyle(color: Colors.black87),),
          //       InkWell(
          //           onTap: (){
          //             resendOTP();
          //           },
          //           child: Text("Resend",
          //             style: TextStyle(decoration: TextDecoration.underline,
          //                 color:Colors.black,fontSize: 16,
          //                 fontWeight: FontWeight.bold),)),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top:36),
            child: MaterialButton(
              height: 55.0,
              minWidth: MediaQuery.of(context).size.width/2.0,
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0))
              ),
              onPressed: (){
                if(otp==smsOTP){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(userEmail: phoneNumber)));
                }else{
                  Fluttertoast.showToast(
                      msg: "Wrong OTP",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2
                  );
                }
              },
              child: Text(
                'Verify',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Color(0xFFF4CC1F),
            ),
          ),
        ],
      ),);
  }
}