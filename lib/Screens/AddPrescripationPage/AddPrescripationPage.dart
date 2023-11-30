import 'package:flutter/material.dart';

import '../../Widgets/textFromField.dart';

class AddPrescripationPage extends StatefulWidget {
  const AddPrescripationPage({Key? key}) : super(key: key);

  @override
  State<AddPrescripationPage> createState() => _AddPrescripationPageState();
}

class _AddPrescripationPageState extends State<AddPrescripationPage> {
  TextEditingController addPrescripationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Add Prescripation'),
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
              SizedBox(height: 24.0),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(2.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.transparent.withOpacity(0.4),
                        blurRadius: 18,
                        offset: Offset(0, 7)),
                  ],
                ),
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  controller: addPrescripationController,
                  keyboardType:TextInputType.text,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter prescripation';
                    }
                    return null;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:Color(0xFF032737),
                    prefixIcon: Icon(Icons.feedback, color: Colors.white, size: 20),
                    hintText: "Prescripation",
                    hintStyle: TextStyle(
                        color: Colors.white70
                    ),
                    errorStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF539cd4),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Color(0xFF539cd4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(5.0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color:Color(0xFF539cd4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                child: MaterialButton(
                  height: 55.0,
                  minWidth: MediaQuery.of(context).size.width / 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(24.0),
                          bottomLeft: Radius.circular(24.0),
                          bottomRight: Radius.circular(5.0))
                  ),
                  onPressed: (){},
                  child: Text(
                    'Submit',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Color(0xFFF4CC1F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
