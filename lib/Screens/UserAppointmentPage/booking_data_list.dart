import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ViewReportPage.dart';

class BookingDataListView extends StatelessWidget {
  const BookingDataListView(
      {Key? key,
        required this.doctorName,
        required this.serviceName,
        required this.bookingDate,
        required this.status,
        required this.prescripation,
        required this.report,
        required this.animationController,
        required this.animation,
        required this.callback})
      : super(key: key);

  final String doctorName;
  final String serviceName;
  final String bookingDate;
  final String status;
  final String prescripation;
  final String report;
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
                                // Text("Full Name: ",
                                //   textAlign: TextAlign.start,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.black54,
                                //       fontSize: 14),
                                // ),
                                Text(doctorName,
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
                            SizedBox(height: 4,),
                            status=="Completed"?  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Prescripation: ",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                                Expanded(
                                  child: Text(prescripation,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ):Container(),
                            SizedBox(height:status=="Completed"?16: 0,),
                            status=="Completed"?InkWell(
                              onTap: (){
                                Navigator.push(context!, MaterialPageRoute(builder: (context) => ViewReportPage(singleImage: report,)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only( right: 8,),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: new Image.asset("assets/images/health_report_booking.png",fit: BoxFit.fill,),
                                    ),
                                  ),
                                  // IconButton(icon: Icon(Icons.edit),color:Colors.white,iconSize: 20,
                                  //   tooltip: "Modify",
                                  //   onPressed:(){
                                  //    // callbackEdit();
                                  //   },
                                  // ),
                                  Text(status=="Completed"?"View Report":"",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                  SizedBox(width: 16,),
                                ],
                              ),
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