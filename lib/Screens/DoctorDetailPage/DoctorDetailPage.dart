import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Common/CommonApi/CommonClass.dart';
import '../UserAppointmentPage/View_Service_Booking_Page.dart';
import '../UserHomePage/HomePage.dart';
import 'Model/FetchSlotApi.dart';

class DoctorDetailPage extends StatefulWidget {


  final String doctorId;
  final String img;
  final String name;
  final String serviceName;
  final String degree;
  final String exp;
    DoctorDetailPage({required this.doctorId,required this.img,required this.name,required this.serviceName,
      required this.degree,required this.exp});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  late bool loading = false;
  late Razorpay razorpay;

  bool _isLoading = false;
  late FetchSlotApi fetchSlotApi;
  TextEditingController bodController = TextEditingController();
  TextEditingController selectSlotController = TextEditingController();
  String timeSlotId = "";
  int num1=500;
  DateTime? _selectedDate;
  final ImagePicker _picker = ImagePicker();
  late CommonClass commonClass;

  fetchSlotList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'docid':widget.doctorId,
      'date': bodController.text,
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/doctor/fetchslots.php"), body: data);
    fetchSlotApi = FetchSlotApi.fromJson(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!fetchSlotApi.error!) {
        setState(() {
          _isLoading = false;
        });
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

  bookAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("widget.doctorId");
    print(widget.doctorId);
    print(prefs.getString("uid"));
    print(timeSlotId);
    Map data = {
      'did': widget.doctorId,
      'uid': prefs.getString("uid"),
      'sid': timeSlotId,
      'date': bodController.text,
    };
    var response = await http.post(Uri.parse("https://docoappo27.000webhostapp.com/user/bookappointment.php"), body: data);
    commonClass = new CommonClass.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (!commonClass.error) {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
        Fluttertoast.showToast(
            msg: commonClass.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => HomePage()), (
            Route<dynamic> route) => false);
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
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void dispose() {
    super.dispose();
    razorpay.clear();
  }
  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': num1 * 100,
      'name': 'Docoline',
      'description': 'Payment ',
      'prefill': {'contact': '6353369809', 'email': 'sden17112002@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pop(context);
    // Navigator.of(context).pushReplacementNamed(
    //      ViewServiceBookingPage()));
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) =>false );
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: Payment Not Done ", toastLength: Toast.LENGTH_SHORT);
    // loading=false;
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    _handlePaymentSuccess;
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
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
          // IconButton(icon: Icon(Icons.search),color:  Colors.black87,iconSize: 30,
          //   onPressed:(){},
          // ),
          // SizedBox(width: 10,),
        ],
        title: Text("Doctor Details",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold, fontFamily: 'Aileron',)),
        backgroundColor: Color(0xFF08364B),
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFF4CC1F))) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            InkWell(
              onTap:(){},
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
                        image: DecorationImage(
                            image: NetworkImage(widget.img),
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8,),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF4CC1F),width: 2),
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0)),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF032737), Color(0xFF032737)],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(widget.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFF4CC1F),
                                      fontFamily: 'Aileron',
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8,),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF4CC1F),width: 2),
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0)),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF032737), Color(0xFF032737)],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(widget.serviceName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFF4CC1F),
                                      fontFamily: 'Aileron',
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8,),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF539cd4),width: 2),
                    borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(5.0)),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF032737), Color(0xFF032737)],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Degree: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    fontFamily: 'Aileron',
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(widget.degree,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Calibri',
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF539cd4),width: 2),
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(5.0)),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF032737), Color(0xFF032737)],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Experince: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    fontFamily: 'Aileron',
                                    fontSize: 18),
                              ),
                              Expanded(
                                child: Text(widget.exp,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Calibri',
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                readOnly: true,
                onTap: (){
                  _pickDateDialog();
                },
                style: TextStyle(
                    color: Colors.white
                ),
                controller: bodController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select booking date';
                  }
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Color(0xFF032737),
                  prefixIcon: Icon(Icons.date_range, color: Colors.white, size: 20),
                  hintText: "Booking date",
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
            Padding(padding: EdgeInsets.only(left: 24,right: 16,top: 16,bottom: 16),
            child: Text("Choose Time slot",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF032737),
                  fontSize: 18),
            ),),
            SizedBox(height: 6,),
            Container(
              padding: EdgeInsets.only(left: 16,right: 16),
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
                onTap: (){
                  if(bodController.text.isNotEmpty){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select Slot'),
                            content: setupAlertDialogTime(),
                          );
                        }
                    );
                  }else{
                    Fluttertoast.showToast(
                        msg: "Please select date",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2
                    );
                  }
                },
                style: TextStyle(
                    color: Colors.white
                ),
                controller: selectSlotController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select slot';
                  }
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Color(0xFF032737),
                  prefixIcon: Icon(Icons.date_range, color: Colors.white, size: 20),
                  hintText: "Select Slot",
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
            SizedBox(height: 100,)
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16,right: 16, top: 8,bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: MaterialButton(
                height: 50.0,
                minWidth: MediaQuery.of(context).size.width / 1.3,
                shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(24.0),
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(5.0))),
                onPressed: (){
                  if(timeSlotId == "" && bodController.text.isEmpty){
                    Fluttertoast.showToast(
                        msg: "Please select Booking date & Time slot",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2
                    );
                  }else{
                    setState(() {
                      _isLoading = true;
                    });

                    bookAppointment();
                    openCheckout();
                  }
                },
                child: Text('Book Appointment',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Aileron',fontSize: 16),
                ),
                color: Color(0xFFF4CC1F),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime.now(),
        //what will be the previous supported year in picker
        lastDate: DateTime(2024)) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _isLoading = true;
        _selectedDate = pickedDate;
        bodController.text='${DateFormat('yyyy-MM-dd').format(_selectedDate!)}';
        fetchSlotList();
      });
    });
  }

  Widget setupAlertDialogTime() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:fetchSlotApi.status!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              setState(() {
                timeSlotId = fetchSlotApi.status![index].slotid!;
                selectSlotController.text = fetchSlotApi.status![index].time!;
              });
              Navigator.pop(context, true);
            },
            title: Text(fetchSlotApi.status![index].time!),
          );
        },
      ),
    );
  }

}
