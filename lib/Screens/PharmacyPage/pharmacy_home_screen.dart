import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newdocolineproject/Screens/PharmacyPage/pharmacy_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/hospital_app_theme.dart';
import 'Model/MedicalListApi.dart';
import 'Model/pharmacy_list_data.dart';

class PharmacyHomeScreen extends StatefulWidget {
  @override
  _PharmacyHomeScreenState createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  List<PharmacyListData> pharmacyList = PharmacyListData.pharmacyList;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  late MedicalListApi medicalListApi;

  medical()async {
    final response = await http.get(Uri.parse("https://docoappo27.000webhostapp.com/viewmedical.php")
    );
    medicalListApi = new MedicalListApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (medicalListApi != null) {
        setState(() {
          _isLoading = false;
        });
        animationController = AnimationController(
            duration: const Duration(milliseconds: 3000), vsync: this);
        print(response.body);
        return medicalListApi;
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
    _isLoading=true;
    medical();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HospitalAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF08364B) ,
            title: Text('Pharmacy'),
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
          body:_isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                          ];
                        },
                        body: Container(
                          padding: const EdgeInsets.only(top: 16),
                          color:
                          HospitalAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: medicalListApi.medical!.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                              medicalListApi.medical!.length > 10 ? 10 :medicalListApi.medical!.length;
                              final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval(
                                          (1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return PharmacyListView(
                                callback: () {},
                                pharmacyListData: medicalListApi.medical![index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}