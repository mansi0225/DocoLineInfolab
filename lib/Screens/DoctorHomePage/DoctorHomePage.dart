import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newdocolineproject/Screens/DoctorHomePage/doctor_booking_data_list.dart';
import 'package:newdocolineproject/Screens/DoctorProfilePage/DoctorProfilePage.dart';
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
import '../AddSlotsPage/AddSlotsPage.dart';
import '../LaboratoryScreen/laboratory_home_screen.dart';
import '../UserAppointmentPage/Model/booking.dart';
import '../UserProfile/ProfilePage.dart';
import 'Model/FetchDoctorAppointmentApi.dart';

class DoctorHomePage extends StatefulWidget {
  static final String path = "lib/src/pages/navigation/drawer2.dart";

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>  with TickerProviderStateMixin{
  bool _isLoading = false;
  late AnimationController animationController;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final Color primary =  Color(0xFF08364B);

  final Color active = Colors.white;

  final Color divider = Colors.white60;

  String userName = "User";
  String userEmail = "";
  late FetchDoctorAppointmentApi fetchAppointmentApi;

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
      _isLoading = true;
    });
    viewAppointmentList();
  }


  viewAppointmentList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'did': prefs.getString('uid'),
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/doctor/fetchappointments.php"), body: data);
    fetchAppointmentApi = FetchDoctorAppointmentApi.fromJson(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!fetchAppointmentApi.error!) {
        setState(() {
          _isLoading = false;
        });
        animationController = AnimationController(
            duration: const Duration(milliseconds: 3000), vsync: this);
        print(response.body);
      }else{
        setState(() {
          _isLoading = false;
        });
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
    newFieldName();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
            fetchAppointmentApi.status!.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: fetchAppointmentApi.status!.length,
              padding: const EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final int count =
                fetchAppointmentApi.status!.length > 10 ? 10 : fetchAppointmentApi.status!.length;
                final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval(
                            (1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();
                return DoctorBookingDataListView(
                  callback: () {},
                  animation: animation,
                  animationController: animationController,
                  appointmentId: fetchAppointmentApi.status![index].appoid!,
                  userName: fetchAppointmentApi.status![index].uname!,
                  bookingDate: fetchAppointmentApi.status![index].date!,
                  status: fetchAppointmentApi.status![index].astatus == "0" ? "Pending":"Completed",
                );
              },
            ):Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No Appointment Yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:20,color:Colors.black,fontWeight: FontWeight.bold,)),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorProfilePage()));
                      },
                      child: _buildRow(Icons.person_pin, "Profile")
                  ),
                  _buildDivider(),
                  InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AddSlotPage()));
                    },
                      child: _buildRow(Icons.calendar_month_outlined, "Add Slots")
                  ),
                  _buildDivider(),
                  InkWell(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                      },
                      child: _buildRow(Icons.info_sharp, "About Us")
                  ),
                  //_buildDivider(),
                  // InkWell(
                  //     onTap: (){
                  //       //  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                  //     },
                  //     child: _buildRow(Icons.info_sharp, "FAQ's")
                  // ),
                  // _buildDivider(),
                  // InkWell(
                  //     onTap: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                  //     },
                  //     child: _buildRow(Icons.feedback, "Feedback")
                  // ),
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