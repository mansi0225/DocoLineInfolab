import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../DoctorDetailPage/DoctorDetailPage.dart';
import 'Model/DoctorListApi.dart';
import 'doctor_list_view.dart';

class ViewDoctorPage extends StatefulWidget {
  final String hospitalId;
  final String hospitalName;
  ViewDoctorPage({required this.hospitalId,required this.hospitalName});
  @override
  _ViewDoctorPageState createState() => _ViewDoctorPageState(hospitalId,hospitalName);
}

class _ViewDoctorPageState extends State<ViewDoctorPage> with TickerProviderStateMixin{
  String hospitalId;
  String hospitalName;
  _ViewDoctorPageState(this.hospitalId,this.hospitalName);
  static final String path = "lib/src/pages/ecommerce/ecommerce2.dart";
  late AnimationController animationController;
  //late List<ViewServiceListApi>  viewServiceListApi = [];
  late DoctorListApi doctorListApi;
  bool _isLoading = false;

  final List<Map> items = [
    {
      "title": "D and C",
      "category": "Bucket",
      "price": "5500",
      "tags": "#Cotton #polyster #Branded design",
      "image": "https://images.emedicinehealth.com/images/4453/4453-4502-12190-21550.jpg"
    },
    {
      "title": "Diagnostic laparoscopy",
      "category": "Bucket",
      "price": "67000",
      "tags": "#Cotton #polyster #Branded design",
      "image": "https://www.urologyhealth.org/Images/Conditions/Female_Urinary-Tract.jpg"
    },
    {
      "title": "Mest Takel",
      "category": "Bucket",
      "price": "67000",
      "tags": "#Cotton #polyster #Branded design",
      "image": "https://images.emedicinehealth.com/images/4453/4453-4502-12190-21550.jpg"
    },
  ];

  viewDoctorList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'cat':hospitalName,
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/user/fetchdoctor.php"), body: data);
    doctorListApi = new DoctorListApi.fromJson(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!doctorListApi.error!) {
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
    viewDoctorList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Doctor List'),
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
        child: doctorListApi.details!.isNotEmpty ? ListView.builder(
          itemCount: doctorListApi.details!.length,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final int count =
            doctorListApi.details!.length > 10 ? 10 :  doctorListApi.details!.length;
            final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                        (1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn)));
            animationController.forward();
            return DoctorListView(
              callback: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailPage(doctorId: doctorListApi.details![index].did!,
                degree: doctorListApi.details![index].ddegree!,exp: doctorListApi.details![index].dexp! ,
                  img: "https://docoappo27.000webhostapp.com/doctor/${doctorListApi.details![index].dp!}",
                  name:doctorListApi.details![index].dfname! ,serviceName: doctorListApi.details![index].dabout!,)));
              },
              animation: animation,
              animationController: animationController,
              image:  doctorListApi.details![index].dp!,
              name:  doctorListApi.details![index].dfname!,
              exp: doctorListApi.details![index].dexp!,
              city: doctorListApi.details![index].dcity!,
              sortName: doctorListApi.details![index].dabout!,
              serviceId: "1",
            );
          },
        ):Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("No doctor available",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:20,color:Colors.black,fontWeight: FontWeight.bold,)),
          ),
        ),
      ),
    );
  }

  // Widget _buildListView(BuildContext context, int index) {
  //   if (index == 0)
  //     return Container(
  //       padding: EdgeInsets.all(10.0),
  //     );
  //   Map item = items[index - 1];
  //   return _buildShopItem(item);
  // }
  //
  // Widget _buildShopItem(Map item) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
  //     margin: EdgeInsets.only(bottom: 20.0),
  //     height: 200,
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   color:Color(0xFF032737),
  //                   image: DecorationImage(
  //                       image: NetworkImage(item["image"]), fit: BoxFit.cover),
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Color(0xFF032737).withOpacity(0.7),
  //                         offset: Offset(5.0, 5.0),
  //                         blurRadius: 10.0)
  //                   ]),
  //             )),
  //         Expanded(
  //           child: Container(
  //             padding: EdgeInsets.all(20.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   item["title"],
  //                   style:
  //                   TextStyle(fontSize: 18.0, color:Colors.white ,fontWeight: FontWeight.w700),
  //                 ),
  //                 SizedBox(
  //                   height: 5.0,
  //                 ),
  //                 Text(item["category"],
  //                     style: TextStyle(color: Colors.grey, fontSize: 14.0)),
  //                 SizedBox(
  //                   height: 20.0,
  //                 ),
  //                 Text("\₹${item["price"].toString()}",
  //                     style: TextStyle(
  //                       color: Colors.red,
  //                       fontSize: 24.0,
  //                     )),
  //
  //               ],
  //             ),
  //             margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                     bottomRight: Radius.circular(10.0),
  //                     topRight: Radius.circular(10.0)),
  //                 color:Color(0xFF032737),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Color(0xFF032737).withOpacity(0.7),
  //                       offset: Offset(5.0, 5.0),
  //                       blurRadius: 10.0)
  //                 ]),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

}
