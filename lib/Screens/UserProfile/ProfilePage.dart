import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';

import '../../Widgets/textFromField.dart';
import '../Common/CommonApi/CommonClass.dart';
import 'Model/UserProfileAPI.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  DateTime? _selectedDate;
  int _groupValue = -1;
  String? gender;
  int? city;
  int? state;

  final formKey = new GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController selectCityController = TextEditingController();
  String userName = "User";
  String userEmail = "";
  late  UserProfileApi userProfileApi;
  late CommonClass commonClass;

  File? _image;
  Future _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
      nameController.text = sharedPreferences.getString('uname')!;
      emailController.text = sharedPreferences.getString('uemail')!;
      userName = sharedPreferences.getString('uname')!;
      userEmail = sharedPreferences.getString('uemail')!;
    });
    getProfileDetails();
  }

  getProfileDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("uid"));
    Map data = {
      'uid': sharedPreferences.getString("uid"),
    };

    var response = await http.post( Uri.parse("https://docoappo27.000webhostapp.com/user/uprofileview.php"), body: data);
    userProfileApi = new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!userProfileApi.error!) {
        setState(() {
          _isLoading = false;
        });
        print(response.body.toString());
        phoneController.text = userProfileApi.user!.umobile!;
        addressController.text = userProfileApi.user!.uadd!;
        ageController.text = userProfileApi.user!.uage!;
        bloodGroupController.text = userProfileApi.user!.ubloodg!;
        selectStateController.text = userProfileApi.user!.ustate!;
        selectCityController.text = userProfileApi.user!.ucity!;
        _groupValue = userProfileApi.user!.ugender! == "Male" ? 1 : userProfileApi.user!.ugender! == "Female" ? 2 : -1;
        gender = userProfileApi.user!.ugender! == "Male" ? "Male" : userProfileApi.user!.ugender! == "Female" ? "Female" :"";
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

  updateProfileDetails(String age,bloodGroup,umobile,uadd,ucity,ustate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'uid': sharedPreferences.getString("uid"),
      'ufname': sharedPreferences.getString("uname"),
      'ulname': sharedPreferences.getString("uname"),
      'ugender': gender,
      'uage': age,
      'ubloodg': bloodGroup,
      'umobile': umobile,
      'uadd': uadd,
      'ucity': ucity,
      'ustate': ustate,
    };

    var response = await http.post( Uri.parse("https://docoappo27.000webhostapp.com/user/updateprofile.php"), body: data);
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
                      width: 125.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF08364B),
                          border: Border.all(
                            color: Color(0xFF539cd4),
                            width: 4.0,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 9.0, color:Color(0xFF08364B))
                          ]),
                  child: Center(
                    child: Text(
                      userName[0].toUpperCase(),
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.aBeeZee(
                          fontSize: 54,
                          color:  Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )),
                ),
              ),
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
                                      errorMsg: 'Please enter Name',
                                      keyboardType: TextInputType.text,
                                      textEditingController: nameController,
                                      icon: Icons.person,
                                      hint: "Name",
                                    ),
                                  ),
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
                                      readOnly: false,
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
                                    "Blood Group: ",
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
                                      errorMsg: 'Please enter blood group',
                                      keyboardType: TextInputType.text,
                                      textEditingController: bloodGroupController,
                                      icon: Icons.person,
                                      hint: "Blood group",
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
      setState(() {
        _isLoading = true;
      });
      updateProfileDetails(ageController.text,bloodGroupController.text,phoneController.text,addressController.text,selectStateController.text,selectCityController.text);
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
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              // state = stateApi.data[index].id;
              // selectStateController.text =  stateApi.data[index].stateName;
              // getCity(stateApi.data[index].id.toString());
              // setState(() {
              //   _isLoading = true;
              // });
              Navigator.pop(context, true);
            },
            title: Text("State"),
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