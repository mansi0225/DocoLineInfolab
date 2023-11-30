import 'package:flutter/material.dart';
import 'package:newdocolineproject/Screens/ChooseUserScreen/choice_login.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/fancy_on_boarding.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/page_model.dart';

import '../LoginScreen/LoginPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final pageList = [
    PageModel(
        color: const Color(0xFF08364B),
        heroAssetPath: 'assets/images/hospital.png',
        title: Text('Doctor',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All Doctor are sorted by hospitality rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg/key.svg',
        heroAssetColor: Colors.white),
    PageModel(
        color: const Color(0xFF08364B),
        heroAssetPath: 'assets/images/pharmacy.png',
        title: Text('Medicine',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg/cards.svg',
        heroAssetColor: Colors.white),
    PageModel(
      color: const Color(0xFF08364B),
      heroAssetPath: 'assets/images/pharmacist.png',
      title: Text('Pharmacist',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/svg/shop.svg', heroAssetColor: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
        doneButtonText: "Done",
        // skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => choice_login()), (
                Route<dynamic> route) => false),
        // onSkipButtonPressed: () =>
        //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        //         builder: (BuildContext context) => LoginPage()), (
        //         Route<dynamic> route) => false)
      ),
    );
  }
}
