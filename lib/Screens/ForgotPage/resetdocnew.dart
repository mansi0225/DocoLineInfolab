import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import '../LoginScreen/LoginPage.dart';

class ResetNewDoc extends StatefulWidget {
  @override
  _ResetNewDocState createState() => _ResetNewDocState();
}

class _ResetNewDocState extends State<ResetNewDoc> {
  bool _isLoading = false;
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


  Reset12(String name,email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'dname': name,
      'demail':email,

    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/forget%20password/doctorforgetpass.php"), body: data);
    commonClass = new CommonClass.fromJsonMap(json.decode(response.body.toString()));
    var data1=jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      if (!commonClass.error) {
        setState(() {
          _isLoading = false;
        });

        print(data1["user"]["dpass"].toString());
        var pass11=data1["user"]["dpass"].toString();
        setState(() {
          passwordController.text=pass11;
        });

        print(response.body);
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        //     builder: (BuildContext context) => LoginPage()), (
        //     Route<dynamic> route) => false);
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
                    'Show Password',
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

           // SizedBox(height: 20.0),
           //  Container(
           //    padding: EdgeInsets.only(left: 20, right: 20),
           //    child: CustomTextField(
           //      errorMsg: 'Please enter Confirm Password',
           //      keyboardType: TextInputType.text,
           //      textEditingController: confirmPasswordController,
           //      icon: Icons.lock,
           //      obscureText: true,
           //      hint: "Confirm Password",
           //    ),
           //  ),
           //  SizedBox(height: 20.0),
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
                'Show'.toUpperCase(),
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Color(0xFFF4CC1F),
            ),
          ),
SizedBox(height: 35.0,),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CustomTextField(
              errorMsg: 'Please enter Password',
              keyboardType: TextInputType.text,
              textEditingController: passwordController,
              icon: Icons.lock,
              obscureText: false,
              hint: "Password",
              readOnly: true,
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
      Reset12(nameController.text, emailController.text);
    }
  }

}
