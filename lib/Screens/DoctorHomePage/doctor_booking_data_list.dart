import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdocolineproject/Screens/AddPrescripationPage/AddPrescripationPage.dart';

import '../AddReportPage/AddReportPage.dart';

class DoctorBookingDataListView extends StatelessWidget {
  const DoctorBookingDataListView(
      {Key? key,
        required this.appointmentId,
        required this.userName,
        required this.bookingDate,
        required this.status,
        required this.animationController,
        required this.animation,
        required this.callback})
      : super(key: key);

  final String appointmentId;
  final String userName;
  final String bookingDate;
  final String status;
  final VoidCallback callback;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 8),
              child:InkWell(
                onTap: (){

                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16,top: 8),
                  decoration: BoxDecoration(
                    color: status=="Pending"?Color(0xFF2ca5ab):status=="Completed"?Color(0xFF08364B):Color(0xFF4CAF50),
                    // border: Border.all(
                    //   color: Color(0xFF032737),
                    //   width: 4.0,
                    // ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:  Color(0xFF032737).withOpacity(0.4),
                        offset: const Offset(1, 1),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(5.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text(userName,
                                  textAlign: TextAlign.start,
                                  style:GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Text("Booking Date: ",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                                Text( bookingDate,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status: ",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                                Expanded(
                                  child: Text( status,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:status=="Pending"?12: 4,),
                            status=="Pending"?Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context!, MaterialPageRoute(builder: (context) => AddReportPage(appointmnetId: appointmentId,)));
                                      },
                                      child:Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only( right: 8,),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              child: new Image.asset("assets/images/health_report_booking.png",fit: BoxFit.fill,),
                                            ),
                                          ),
                                          Text(status=="Pending"?"Add Prescripation & Report":"",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.aBeeZee(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 4,),
                              ],
                            ):Container(),
                            SizedBox(height: 16,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}