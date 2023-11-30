import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newdocolineproject/Screens/DoctorHomePage/DoctorHomePage.dart';
import 'package:newdocolineproject/Screens/DoctorSignup/DoctorSignUpPage.dart';
import 'package:newdocolineproject/Screens/ForgotPage/forgetdoc.dart';
import 'package:newdocolineproject/Screens/ForgotPage/forgetuser.dart';
import 'package:newdocolineproject/Widgets/textFromField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ForgotPage/ForgotScreen.dart';
import '../ForgotPage/resetdocnew.dart';
import 'Model/DoctorLoginApi.dart';

class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  bool _isLoading = false;
  bool visibility = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  late DoctorLoginApi loginApi;
  FToast? fToast;

  login(String Email, Password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'demail': Email,
      'dpass': Password,
    };

    var response = await http.post( Uri.parse("https://docoappo27.000webhostapp.com/doctor/dlogin.php"), body: data);
    loginApi = new DoctorLoginApi.fromJson(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!loginApi.error!) {
        setState(() {
          _isLoading = false;
        });
        print(response.body.toString());
        sharedPreferences.setString("uid",loginApi.user!.did!);
        sharedPreferences.setString("uname",loginApi.user!.dname!);
        sharedPreferences.setString("uemail",loginApi.user!.demail!);
        sharedPreferences.setString("role","1");
        print(response.body.toString());

        Fluttertoast.showToast(
            msg: loginApi.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => DoctorHomePage()), (
            Route<dynamic> route) => false);
        print(response.body);
      }else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: loginApi.message!,
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
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF08364B),
      body: Container(
        child: _isLoading ? const Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) :
        Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              headerSection(),
              textSection(),
              buttonSection(),
            ],
          ),
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
        alignment: Alignment.center,
        child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Container(
                width: 120,
                height: 120,
                child: new Image.asset('assets/images/doctor.png'),
              ),
              SizedBox(height: 20,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  alignment: Alignment.centerLeft,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Login',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 8,),
                    Text('Please sign in to continue.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 8,),
                  ],
                )
              ),
            ] ));
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CustomTextField(
                errorMsg: 'Please enter Email',
                keyboardType: TextInputType.text,
                textEditingController: emailController,
                icon: Icons.email,
                hint: "Email",
              ),
            ),
            SizedBox(height: 20.0),
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
                obscureText: visibility,

                style: TextStyle(
                    color: Colors.white
                ),
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Color(0xFF032737),
                  prefixIcon: Icon(Icons.lock, color: Colors.white, size: 20),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(visibility
                        ? Icons.visibility_off
                        : Icons.visibility,color: Colors.white,),
                  ),
                  hintText: "password",
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
            // Container(
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   child : CustomTextField(
            //     errorMsg: 'Please enter Password',
            //     keyboardType: TextInputType.text,
            //     textEditingController: passwordController,
            //     icon: Icons.lock,
            //     obscureText: true,
            //     hint: "Password",
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 5),
            //     child: TextButton(
            //       child: Text('Forgot Password ?',
            //         style: TextStyle(
            //             color: Color(0xFFF4CC1F),
            //             fontWeight: FontWeight.bold
            //         ),
            //       ),
            //       onPressed: (){
            //        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen()));
            //       }
            //         //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen())),
            //     ),),
            // ),
          ],
        ),
      ),
    );
  }



  Container buttonSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            child :MaterialButton(
              height: 55.0,
              minWidth: MediaQuery.of(context).size.width/2.0,
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0))
              ),
              onPressed:_submit,
              child: Text('Login'.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              color: Color(0xFFF4CC1F),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24
              ),
              child: TextButton(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an Account?',
                      style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold
                      ),
                      ),
                      Text(' SignUp',
                        style: TextStyle(
                            color: Color(0xFFF4CC1F),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                    ) ,
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSignUpPage()));
                }
              ),),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DocOtp(),));
            },
            child: Text(
              ' Forget Password',
              style: TextStyle(
                  fontSize: 17.0,
                  color: Color(0xFFF4CC1F),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
   final form = formKey.currentState;
   if (form!.validate()) {
     setState(() {
       _isLoading = true;
     });
    login(emailController.text, passwordController.text);
   }

  }

}
