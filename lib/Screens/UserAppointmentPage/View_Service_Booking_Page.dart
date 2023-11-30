import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/FetchAppointmentApi.dart';
import 'Model/booking.dart';
import 'booking_data_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewServiceBookingPage extends StatefulWidget {
  const ViewServiceBookingPage({Key? key}) : super(key: key);

  @override
  _ViewServiceBookingPageState createState() => _ViewServiceBookingPageState();
}

class _ViewServiceBookingPageState extends State<ViewServiceBookingPage> with TickerProviderStateMixin{
  late AnimationController animationController;
  late FetchAppointmentApi fetchAppointmentApi;
  bool _isLoading = false;


  viewAppointmentList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'uid': prefs.getString("uid"),
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/user/fetchappointments.php"), body: data);
    fetchAppointmentApi = FetchAppointmentApi.fromJson(json.decode(response.body.toString()));
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
    _isLoading = true;
    viewAppointmentList();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Appointments'),
        shadowColor: Colors.white,
        elevation: 10,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back, color:Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
          SizedBox(width: 20,),
        ],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : SafeArea(
        child: fetchAppointmentApi.status!.isNotEmpty ? ListView.builder(
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
            return BookingDataListView(
              callback: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalServices()));
              },
              animation: animation,
              animationController: animationController,
              doctorName: fetchAppointmentApi.status![index].dname!,
              prescripation: fetchAppointmentApi.status![index].prescri!,
              report: fetchAppointmentApi.status![index].report!,
              serviceName: "Service Name",
              bookingDate:fetchAppointmentApi.status![index].date!,
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
      ),
    );
  }
}
