import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import 'Model/DoctorProfileApi.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  DateTime? _selectedDate;
  int _groupValue = -1;
  String? gender;
  int? city;
  int? state;

  final formKey = new GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController selectCityController = TextEditingController();

  late DoctorProfileApi doctorProfileApi;
  String userName = "User";
  String userEmail = "";
  String userProfileImg = "";
  late CommonClass commonClass;
  List<String> serviceList = ["Cardiologists","Dentist","Orthopedic","Gynecologists","Oncologists","Neurologists","Radiologist","Psychiatrists"];

  File? _image;
  Future _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
   // uploadImageMedia(_image!);
  }



  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
      firstNameController.text = sharedPreferences.getString('uname')!;
      emailController.text = sharedPreferences.getString('uemail')!;
      userName = sharedPreferences.getString('uname')!;
      userEmail = sharedPreferences.getString('uemail')!;
    });
    getProfileDetails();
  }

  getProfileDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'did': sharedPreferences.getString("uid"),
    };

    var response = await http.post( Uri.parse("https://docoappo27.000webhostapp.com/doctor/dprofileview.php"), body: data);
    doctorProfileApi = new DoctorProfileApi.fromJson(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!doctorProfileApi.error!) {
        setState(() {
          _isLoading = false;
        });
        print(response.body.toString());
        phoneController.text = doctorProfileApi.user!.dmobile!;
        addressController.text = doctorProfileApi.user!.dhospiadd!;
        ageController.text = doctorProfileApi.user!.dage!;
        degreeController.text = doctorProfileApi.user!.ddegree!;
        expController.text = doctorProfileApi.user!.dexp!;
        aboutController.text = doctorProfileApi.user!.dabout!;
        selectStateController.text = doctorProfileApi.user!.dstate!;
        selectCityController.text = doctorProfileApi.user!.dcity!;
        userProfileImg = "https://docoappo27.000webhostapp.com/doctor/${doctorProfileApi.user!.dp!}";
        _groupValue = doctorProfileApi.user!.dgender! == "Male" ? 1 : doctorProfileApi.user!.dgender! == "Female" ? 2 : -1;
        gender = doctorProfileApi.user!.dgender! == "Male" ? "Male" : doctorProfileApi.user!.dgender! == "Female" ? "Female" :"";
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

   uploadImageMedia(File fileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("https://docoappo27.000webhostapp.com/doctor/dprofileupdate.php"));

    final file = await http.MultipartFile.fromPath('dp', fileImage.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

    imageUploadRequest.fields['did']= prefs.getString("uid")!;
    imageUploadRequest.fields['dfname']= firstNameController.text ;
    imageUploadRequest.fields['dlname']= "" ;
    imageUploadRequest.fields['dgender']= gender!;
    imageUploadRequest.fields['dage']= ageController.text ;
    imageUploadRequest.fields['dmobile']= phoneController.text ;
    imageUploadRequest.fields['dhospiadd']= addressController.text ;
    imageUploadRequest.fields['dabout']= aboutController.text ;
    imageUploadRequest.fields['dexp']= expController.text ;
    imageUploadRequest.fields['dcity']= selectCityController.text ;
    imageUploadRequest.fields['dstate']= selectStateController.text ;
    imageUploadRequest.fields['ddegree']= degreeController.text ;
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
              msg: "SignUp Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2
          );
          Navigator.of(context).pop();
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

  updateProfileDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'did': sharedPreferences.getString("uid"),
      'dfname': sharedPreferences.getString("uname"),
      'dlname': sharedPreferences.getString("uname"),
      'dgender': gender,
      'dage': ageController.text,
      'dmobile': phoneController.text,
      'dhospiadd': addressController.text,
      'dabout': aboutController.text,
      'dexp': expController.text,
      'dcity': selectCityController.text,
      'dstate': selectStateController.text,
      'ddegree': degreeController.text,
    };

    var response = await http.post( Uri.parse("https://docoappo27.000webhostapp.com/doctor/dprofileupdate.php"), body: data);
    commonClass = new CommonClass.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!commonClass.error) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );

        Navigator.of(context).pop();
        print(response.body);
      }else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
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
    newFieldName();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('Profile'),
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
        body:_isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) :  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              InkWell(
                onTap: _getImage,
                child: Center(
                  child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF08364B),
                          border: Border.all(
                            color: Color(0xFF539cd4),
                            width: 4.0,
                          ),
                          image: _image != null ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover) :
                          DecorationImage(
                              image: NetworkImage(userProfileImg),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 9.0, color:Color(0xFF08364B))
                          ])),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Text(
              //     "Black Widow",
              //     textAlign: TextAlign.center,
              //     style:  GoogleFonts.aBeeZee(
              //         fontSize: 36,
              //         color: Color(0xFF08364B),
              //         fontWeight: FontWeight.bold
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 16,left: 16,top: 24),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:Color(0xFF032737),
                    border: Border.all(
                      color: Color(0xFFF4CC1F),
                      width: 4.0,
                    ),
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
                        bottomRight: Radius.circular(5.0)),),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8,top: 8,right: 16,left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  userName,
                                  textAlign: TextAlign.center,
                                  style:  GoogleFonts.aBeeZee(
                                      fontSize: 24,
                                      color:  Color(0xFFF4CC1F),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16,left: 16,top: 24,bottom: 36),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:Color(0xFF032737),
                    border: Border.all(
                      color: Color(0xFF539cd4),
                      width: 4.0,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:  Color(0xFF032737).withOpacity(0.4),
                        offset: const Offset(1, 1),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(36.0),
                        bottomLeft: Radius.circular(36.0),
                        bottomRight: Radius.circular(5.0)),),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8,top: 8,right: 8,left: 8),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Personal Information: ",
                                      textAlign: TextAlign.center,
                                      style:  GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          color:  Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Name: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      readOnly: true,
                                      errorMsg: 'Please enter name',
                                      keyboardType: TextInputType.text,
                                      textEditingController: firstNameController,
                                      icon: Icons.person,
                                      hint: "Name",
                                    ),
                                  ),
                                  // SizedBox(height: 16,),
                                  // Text(
                                  //   "Last Name: ",
                                  //   textAlign: TextAlign.start,
                                  //   style:  GoogleFonts.aBeeZee(
                                  //       fontSize: 16,
                                  //       color:  Colors.white,
                                  //       fontWeight: FontWeight.bold
                                  //   ),
                                  // ),
                                  // SizedBox(height: 6,),
                                  // Container(
                                  //   child: CustomTextField(
                                  //     errorMsg: 'Please enter last name',
                                  //     keyboardType: TextInputType.text,
                                  //     textEditingController: lastNameController,
                                  //     icon: Icons.person,
                                  //     hint: "Last name",
                                  //   ),
                                  // ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Email: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter Email',
                                      keyboardType: TextInputType.text,
                                      textEditingController: emailController,
                                      icon: Icons.email,
                                      hint: "Email",
                                      readOnly: true,
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Phone: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter Phone',
                                      keyboardType: TextInputType.phone,
                                      textEditingController: phoneController,
                                      icon: Icons.phone,
                                      hint: "Phone Number",
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Degree: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter Degree',
                                      keyboardType: TextInputType.text,
                                      textEditingController: degreeController,
                                      icon: Icons.rotate_90_degrees_ccw,
                                      hint: "Degree",
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Experince: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter Experince',
                                      keyboardType: TextInputType.number,
                                      textEditingController: expController,
                                      icon: Icons.contact_page,
                                      hint: "Experince",
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Address: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter Address',
                                      keyboardType: TextInputType.text,
                                      textEditingController: addressController,
                                      icon: Icons.person_pin_circle,
                                      hint: "Address",
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Gender: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: Colors.white,
                                          ),
                                           child: Radio(
                                              activeColor: Colors.white,
                                              value: 1,
                                              groupValue: _groupValue,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _groupValue = newValue as int;
                                                  gender = "Male";
                                                });
                                              }
                                        ),
                                         ),
                                         Text(
                                          'Male',
                                          style: new TextStyle(fontSize: 16.0, color: Colors.white),
                                        ),
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                              unselectedWidgetColor: Colors.white,
                                          ),
                                           child: Radio(
                                              activeColor: Colors.white,
                                              value: 2,
                                              groupValue: _groupValue,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _groupValue = newValue as int;
                                                  gender = "Female";
                                                });
                                              }
                                        ),
                                         ),
                                         Text(
                                          'Female',
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Age: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                    child: CustomTextField(
                                      errorMsg: 'Please enter age',
                                      keyboardType: TextInputType.number,
                                      textEditingController: ageController,
                                      icon: Icons.person,
                                      hint: "Age",
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Service: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
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
                                      readOnly: true,
                                      onTap: (){     showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Select Service:'),
                                              content: setupAlertDialogState(),
                                            );
                                          }
                                      );

                                      },
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      controller: aboutController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please select service';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:Color(0xFF032737),
                                        prefixIcon: Icon(Icons.date_range, color: Colors.white, size: 20),
                                        hintText: "Select Service",
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
                                  SizedBox(height: 16,),
                                  Text(
                                    "State: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
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
                                      readOnly: false,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      controller: selectStateController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter State';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:Color(0xFF032737),
                                        prefixIcon: Icon(Icons.date_range, color: Colors.white, size: 20),
                                        hintText: "Select State",
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
                                  SizedBox(height: 16,),
                                  Text(
                                    "City: ",
                                    textAlign: TextAlign.start,
                                    style:  GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
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
                                      readOnly: false,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      controller: selectCityController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter City';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:Color(0xFF032737),
                                        prefixIcon: Icon(Icons.date_range, color: Colors.white, size: 20),
                                        hintText: "Select City",
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
                                  SizedBox(height:30,),
                                  Center(
                                    child: Container(
                                      child :MaterialButton(
                                        height: 55.0,
                                        minWidth: MediaQuery.of(context).size.width/2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:  BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(24.0),
                                                bottomLeft: Radius.circular(24.0),
                                                bottomRight: Radius.circular(5.0))
                                        ),
                                        onPressed:_submit,
                                        child: Text('Update'.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        color: Color(0xFFF4CC1F),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
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
        setState(() {
          _isLoading = true;
        });
        updateProfileDetails();
      }

    }

  }

  Widget setupAlertDialogCountry() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:6,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              // country = countryApi.data[index].id;
              // selectCountryController.text =  countryApi.data[index].countryName;
              // getState(countryApi.data[index].id.toString());
              // setState(() {
              //   _isLoading = true;
              // });
              Navigator.pop(context, true);
            },
            title: Text("Name"),
          );
        },
      ),
    );
  }

  Widget setupAlertDialogState() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: serviceList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              aboutController.text =  serviceList[index];
              Navigator.pop(context, true);
            },
            title: Text(serviceList[index]),
          );
        },
      ),
    );
  }
  Widget setupAlertDialogCity() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              // city =  cityApi.data[index].id;
              // selectCityController.text =cityApi.data[index].cityName;
              Navigator.pop(context, true);
            },
            title: Text("City"),
          );
        },
      ),
    );
  }
}