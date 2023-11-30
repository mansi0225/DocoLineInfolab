import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import '../DoctorHomePage/DoctorHomePage.dart';

class AddReportPage extends StatefulWidget {
  final String appointmnetId;

  AddReportPage({required this.appointmnetId,});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  TextEditingController addPrescripationController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  late CommonClass commonClass;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? _image;
  Future _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  uploadImageMedia(File fileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("https://docoappo27.000webhostapp.com/doctor/addrp.php"));

    final file = await http.MultipartFile.fromPath('report', fileImage.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

    imageUploadRequest.fields['aid']= widget.appointmnetId;
    imageUploadRequest.fields['prescription']= addPrescripationController.text ;
    imageUploadRequest.files.add(file);
    try {
      _isLoading = true;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        if(streamedResponse.statusCode==200){
          setState(() {
            _isLoading=false;
          });
          Fluttertoast.showToast(
              msg: "Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2
          );
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => DoctorHomePage()), (
              Route<dynamic> route) => false);
          print(streamedResponse.stream);
          print(value);
        }else{
          setState(() {
            _isLoading=false;
          });
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2
          );
          print(value);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Add Prescripation & Report'),
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
      body:_isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : SingleChildScrollView(
        child: Form(
          key: formKey,
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
                SizedBox(height: 16.0),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Choose Report:', style: TextStyle(
                            color:  Color(0xFF08364B),
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900)),
                      ),
                      Padding(padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: _getImage,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _image==null?Image.asset(
                                'assets/images/placeholder.png',height: 200,width: double.infinity,
                                fit: BoxFit.fill,):
                              Image.file(
                                _image!,height: 200,width: double.infinity,
                                fit: BoxFit.fill,),
                            ),

                          ),
                        ),)
                    ],
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
                    onPressed: _submit,
                    child: Text(
                      'Submit',
                      style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Color(0xFFF4CC1F),
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      if(_image != null){
        setState(() {
          _isLoading = true;
        });
        uploadImageMedia(_image!);
      }else{
        Fluttertoast.showToast(
            msg: "Please select image",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }

    }

  }

}
