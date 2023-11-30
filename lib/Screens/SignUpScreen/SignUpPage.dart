import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import '../ForgotPage/resetnew.dart';
import '../LoginScreen/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  bool visibility = true;
  bool visibility1 = true;
  final formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late CommonClass commonClass;
  String? gender;
  int? city;
  int? state;
  int? country;


  signUp(String name,email,password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'uname': name,
      'uemail':email,
      'upass': password,
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/user/usignupinsert.php"), body: data);
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
            builder: (BuildContext context) => LoginPage()), (
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
  void initState() {
    super.initState();
  }



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
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF08364B),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
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
        child: Column(children: <Widget>[
//              Container(
//                width: 200,
//                height: 200,
//                child: new Image.asset('assets/images/hxn_logo.png'),
//              ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Create Account',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please fill the input blow here',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              )),
        ]));
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
                errorMsg: 'Please enter Name',
                keyboardType: TextInputType.text,
                textEditingController: nameController,
                icon: Icons.person,
                hint: "Name",
              ),
            ),
            SizedBox(height: 20.0),
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
            // Container(
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   child: CustomTextField(
            //     errorMsg: 'Please enter Phone',
            //     keyboardType: TextInputType.phone,
            //     textEditingController: phoneController,
            //     icon: Icons.phone,
            //     hint: "Phone",
            //   ),
            // ),
            // SizedBox(height: 20.0),
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
                obscureText: visibility1,

                style: TextStyle(
                    color: Colors.white
                ),
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter confirm password";
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
                        visibility1 = !visibility1;
                      });
                    },
                    icon: Icon(visibility1
                        ? Icons.visibility_off
                        : Icons.visibility,color: Colors.white,),
                  ),
                  hintText: "confirm-password",
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
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            child: MaterialButton(
              height: 55.0,
              minWidth: MediaQuery.of(context).size.width / 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0))
              ),
              onPressed: _submit,
              child: Text(
                'SignUp'.toUpperCase(),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Color(0xFFF4CC1F),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' Login',
                        style: TextStyle(
                            color: Color(0xFFF4CC1F),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                   // _submit();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));

                  }),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetNew(),));
            },
            child: Text(
              ' Reset Password',
              style: TextStyle(
                fontSize: 17.0,
                  color: Color(0xFFF4CC1F),
                  fontWeight: FontWeight.bold

              ),
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
      if(passwordController.text==confirmPasswordController.text){
        signUp(nameController.text, emailController.text, passwordController.text);
      }
      else{
        _isLoading=false;
        Fluttertoast.showToast(
            msg: "Mismatched Password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }
    }
  }

}
