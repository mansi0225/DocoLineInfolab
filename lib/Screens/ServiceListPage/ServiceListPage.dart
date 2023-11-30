import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdocolineproject/Screens/DoctorListPage/ViewDoctorPage.dart';

import '../../Widgets/textFromField.dart';
import '../PharmacyPage/Model/pharmacy_list_data.dart';
import 'Model/service_list_data.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({Key? key}) : super(key: key);

  @override
  State<ServiceListPage> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceListPage> {
  List<ServiceListData> pharmacyList = ServiceListData.pharmacyList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Service List'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: pharmacyList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctorPage(hospitalId: "1", hospitalName: pharmacyList[index].titleTxt)));
                      },
                      child:  Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          // child: Image.asset(
                          //   widget.img,
                          //   fit: BoxFit.cover,
                          // ),
                          child:Column(
                            children: [
                            Padding(padding:EdgeInsets.only(top: 16) ,
                            child:FadeInImage(
                              height:80,
                              image: AssetImage(
                                  pharmacyList[index].imagePath),
                              placeholder: AssetImage(
                                  'assets/images/placeholder.png'),
                              fit: BoxFit.fill,
                            ),),
                              SizedBox(height: 10,),
                              Text(
                                pharmacyList[index].titleTxt,
                                textAlign: TextAlign.center,
                                style:  GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color:  Color(0xFF08364B),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
