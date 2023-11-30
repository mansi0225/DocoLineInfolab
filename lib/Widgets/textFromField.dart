import 'package:flutter/material.dart';
import 'package:newdocolineproject/Widgets/responsive_widget.dart';


class CustomTextField extends StatefulWidget {
  final String hint;
  final String errorMsg;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final IconData icon;

  CustomTextField(
      {required this.hint,
        required this.errorMsg,
        required this.textEditingController,
        required this.keyboardType,
        required this.icon,
        this.obscureText= false,
        this.readOnly= false,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double? _width;
  bool visibility = true;
  double? _pixelRatio;

  bool? large;

  bool? medium;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium=  ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    return Container(
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
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        style: TextStyle(
          color: Colors.white
        ),
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.errorMsg;
          }
    // else if( !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
    //     return "Enter Correct Email Address";
    //    }
          return null;
        },
        cursorColor: Colors.white,

        decoration: InputDecoration(
          filled: true,
          fillColor:Color(0xFF032737),
          prefixIcon: Icon(widget.icon, color: Colors.white, size: 20),
          hintText: widget.hint,

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
    );
  }
}