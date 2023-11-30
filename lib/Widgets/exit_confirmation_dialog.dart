import 'package:flutter/material.dart';
import 'package:newdocolineproject/Screens/ChooseUserScreen/choice_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/LoginScreen/LoginPage.dart';

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 300,
    decoration: BoxDecoration(
        color: Color(0xFF373737),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/images/exit.png', height: 120, width: 120,),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
        ),
        SizedBox(height: 24,),
        Text('Are You Sure want to Logout?', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        SizedBox(height: 24,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              await pref.setBool('seen', true);
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (BuildContext context) => choice_login()), (
                    Route<dynamic> route) => false);
            }, child: Text('Yes'), color: Color(0xFFF4CC1F), textColor:Color(0xFF373737),),
            SizedBox(width: 8,),
            RaisedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No'),color: Color(0xFFF4CC1F), textColor: Color(0xFF373737),),
          ],
        )
      ],
    ),
  );
}