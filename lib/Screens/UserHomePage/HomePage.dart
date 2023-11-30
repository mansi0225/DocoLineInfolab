import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newdocolineproject/Screens/FeedbackPage/FeedbackPage.dart';
import 'package:newdocolineproject/Screens/PharmacyPage/pharmacy_home_screen.dart';
import 'package:newdocolineproject/Screens/ServiceListPage/ServiceListPage.dart';
import 'package:newdocolineproject/Screens/UserAppointmentPage/View_Service_Booking_Page.dart';
import 'package:newdocolineproject/Widgets/oval-right-clipper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/OnBoardingScreens/PackagesFiles/swiper.dart';
import '../../Widgets/OnBoardingScreens/PackagesFiles/swiper_pagination.dart';
import '../../Widgets/exit_confirmation_dialog.dart';
import '../AboutUsPage/about_us.dart';
import '../LaboratoryScreen/laboratory_home_screen.dart';
import '../UserProfile/ProfilePage.dart';

class HomePage extends StatefulWidget {
  static final String path = "lib/src/pages/navigation/drawer2.dart";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final Color primary =  Color(0xFF08364B);

  final Color active = Colors.white;

  final Color divider = Colors.white60;

  String userName = "User";
  String userEmail = "";

  final List<String> images = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('uname')!;
      userEmail = sharedPreferences.getString('uemail')!;
    });

  }

  @override
  void initState() {
    newFieldName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Hi ' + userName),
        shadowColor: Colors.white,
        elevation: 10,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          SizedBox(width: 20,),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 272,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.all(16.0),
              child:
              Swiper(
                fade: 0.0,
                index: 0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.fill)),
                      ),
//                      Container(
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.only(
//                                  bottomLeft: Radius.circular(10.0),
//                                  bottomRight: Radius.circular(10.0))),
//                          child: ListTile(
//                            subtitle: Text("awesome image caption"),
//                            title: Text("Awesome image"),
//                          ))
                    ],
                  );
                },
                itemCount: 3,
                scale: 1.0,
                autoplay: true,
                pagination: SwiperPagination(),

              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Near by Services",
                  textAlign: TextAlign.start,
                  style:  GoogleFonts.aBeeZee(
                      fontSize: 24,
                      color:Color(0xFF032737),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:  InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceListPage()));
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color:Color(0xFF032737),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xFF032737).withOpacity(0.7),
                        offset: const Offset(1, 1),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(5.0)),),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16,left: 16,right: 8,bottom: 16),
                        child:FadeInImage(
                          width: 65,
                          height: 65,
                          image:  AssetImage('assets/images/hospital_departments.png'),
                          placeholder: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8,right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Doctors",
                                  textAlign: TextAlign.center,
                                  style:  GoogleFonts.aBeeZee(
                                      fontSize: 24,
                                      color:  Color(0xFFF4CC1F),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                // SizedBox(height: 4,),
                                // Text(
                                //   "200 ",
                                //   textAlign: TextAlign.center,
                                //   style:  GoogleFonts.aBeeZee(
                                //       fontSize: 20,
                                //       color: Color(0xFFF4CC1F),
                                //       fontWeight: FontWeight.bold
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.white.withAlpha(20),
                          ),
                          child: Icon(Icons.arrow_forward_ios, color:Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LaboratoryHomeScreen()));
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color:Color(0xFF032737),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:Color(0xFF032737).withOpacity(0.7),
                        offset: const Offset(1, 1),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(5.0)),),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8,left: 16,right: 8,bottom: 8),
                        child:FadeInImage(
                          width: 65,
                          height: 65,
                          image:  AssetImage('assets/images/laboratory_red.png'),
                          placeholder: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8,right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Diagnostic",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 24,
                                      color: Color(0xFFF4CC1F),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                // SizedBox(height: 4,),
                                // Text(
                                //   "200 ",
                                //   textAlign: TextAlign.center,
                                //   style:  GoogleFonts.aBeeZee(
                                //       fontSize: 20,
                                //       color: Color(0xFFF4CC1F),
                                //       fontWeight: FontWeight.bold
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.white.withAlpha(20),
                          ),
                          child: Icon(Icons.arrow_forward_ios, color:Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => PharmacyHomeScreen()));
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color:Color(0xFF032737),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:Color(0xFF032737).withOpacity(0.7),
                        offset: const Offset(1, 1),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(5.0)),),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8,left: 16,right: 8,bottom: 8),
                        child:FadeInImage(
                          width: 65,
                          height: 65,
                          image:  AssetImage('assets/images/pills.png'),
                          placeholder: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8,right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Pharmacy",
                                  textAlign: TextAlign.center,
                                  style:  GoogleFonts.aBeeZee(
                                      fontSize: 24,
                                      color:   Color(0xFFF4CC1F),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                // SizedBox(height: 4,),
                                // Text(
                                //   "200 ",
                                //   textAlign: TextAlign.center,
                                //   style:  GoogleFonts.aBeeZee(
                                //       fontSize: 20,
                                //       color:  Color(0xFFF4CC1F),
                                //       fontWeight: FontWeight.bold
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.white.withAlpha(20),
                          ),
                          child: Icon(Icons.arrow_forward_ios, color:Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
//      body: SingleChildScrollView(
//        padding: const EdgeInsets.all(16.0),
//        child: Column(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 200,
//              decoration: BoxDecoration(
//                  color: Colors.deepOrange,
//                  borderRadius: BorderRadius.circular(10.0)),
//            ),
//            SizedBox(height: 10.0),
//            Container(
//              width: double.infinity,
//              height: 200,
//              decoration: BoxDecoration(
//                  color: Colors.lightGreen,
//                  borderRadius: BorderRadius.circular(10.0)),
//            ),
//            SizedBox(height: 10.0),
//            Container(
//              width: double.infinity,
//              height: 200,
//              decoration: BoxDecoration(
//                  color: Colors.pink,
//                  borderRadius: BorderRadius.circular(10.0)),
//            ),
//          ],
//        ),
//      ),
    );
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Color(0xFFF4CC1F),
                      ),
                      onPressed: () {
                        showDialog(context: context, builder: (context) => ExitConfirmationDialog());
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(0xFFF4CC1F), Color(0xFFF4CC1F)])),
                    child: Center(
                      child: Text(
                        userName[0].toUpperCase(),
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.aBeeZee(
                            fontSize: 36,
                            color:  Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    userName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: _buildRow(Icons.home, "Home")
                  ),
                  _buildDivider(),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                      },
                      child: _buildRow(Icons.person_pin, "Profile")
                  ),
                  _buildDivider(),
                  InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewServiceBookingPage()));
                    },
                      child: _buildRow(Icons.calendar_month_outlined, "My Appointments")
                  ),
                  _buildDivider(),
                  InkWell(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                      },
                      child: _buildRow(Icons.info_sharp, "About Us")
                  ),
                  _buildDivider(),
                  // InkWell(
                  //     onTap: (){
                  //       //  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                  //     },
                  //     child: _buildRow(Icons.info_sharp, "FAQ's")
                  // ),
                  // _buildDivider(),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                      },
                      child: _buildRow(Icons.feedback, "Feedback")
                  ),
                  _buildDivider(),
                  InkWell(
                      onTap: (){
                       showDialog(context: context, builder: (context) => ExitConfirmationDialog());
                      },
                      child: _buildRow(Icons.logout, "Logout")),
                  _buildDivider(),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
      ]),
    );
  }
}