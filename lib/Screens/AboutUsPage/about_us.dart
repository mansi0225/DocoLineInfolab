import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('About Us'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style:  GoogleFonts.aBeeZee(
                  color: Color(0xFF08364B),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: false,
                  stopPauseOnTap: true,
                  animatedTexts: [
                    TypewriterAnimatedText('Docoline is an initiative to reignite the slowly dying art of simple community living.\n'
                        ' It is a platform that instigates individual to perform simple tasks that would add value to not just their lives but to people around them as well.\n'
                        ' It is an opportunity to come out of the virtual world and get back to our real lives.\n'
                        ' In simple words, it is the \n'
                        '\"Health of Life\"',
                      textAlign:TextAlign.center ,
                      speed: const Duration(milliseconds: 50),),
                  ],
                  onTap: () {
                    // print("Tap Event");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
