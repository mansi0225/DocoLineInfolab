import 'package:flutter/material.dart';
import 'package:newdocolineproject/Screens/DoctorLoginScreen/DoctorLoginPage.dart';
import 'package:newdocolineproject/Screens/LoginScreen/LoginPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class choice_login  extends StatefulWidget {
  @override
  State<choice_login > createState() => _choice_loginState();
}

class _choice_loginState extends State<choice_login > {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF08364B),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Sign up by choosing your role.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                //! Doctor Signup Button
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('pressed on doctor');
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: DoctorLoginPage()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(top: 10, left: 20),
                              child: FaIcon(
                                FontAwesomeIcons.userMd,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "I'm a doctor",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //! Patient Signup Button
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('pressed on patient');
                    Navigator.push(
                        context,
                        PageTransition(
                            child: LoginPage(),
                            type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color:Colors.white,),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: FaIcon(
                                FontAwesomeIcons.procedures,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "I'm a patient",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}