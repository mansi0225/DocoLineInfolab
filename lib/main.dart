import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newdocolineproject/Screens/LoginScreen/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/ChooseUserScreen/choice_login.dart';
import 'Screens/OnBoardingScreen/OnBoardingPage.dart';


void main() => runApp(MaterialApp(
  theme:
  ThemeData(primaryColor: Color(0xFF08364B),accentColor:Color(0xFF032737)),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, checkFirstSeen);
  }

  void navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => OnBoardingPage()), (
        Route<dynamic> route) => false);
  }


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    await prefs.setBool('seen', true);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => choice_login()), (
        Route<dynamic> route) => false);
    // if (_seen) {
    //   if(prefs.getInt('user_id') != null) {
    //   //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
    //   }else{
    //     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    //     //     builder: (BuildContext context) => LoginPage()), (
    //     //     Route<dynamic> route) => false);
    //   }
    //
    // } else {
    //   await prefs.setBool('seen', true);
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    //       builder: (BuildContext context) => OnBoardingPage()), (
    //       Route<dynamic> route) => false);
    // }
  }

  //  checkLoginStatus() async {
  //    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //    if(sharedPreferences.getString('user_Id') != null) {
  //      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
  //    }else{
  //      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
  //          builder: (BuildContext context) => LoginScreen()), (
  //          Route<dynamic> route) => false);
  //    }
  //  }

  @override
  void initState(){
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 3));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/images.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
              Text('DocoLine',
                style: TextStyle(
                    color: Color(0xFF032737),
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}