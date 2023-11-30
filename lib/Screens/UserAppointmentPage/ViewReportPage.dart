import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewReportPage extends StatefulWidget {
  final String singleImage;

  ViewReportPage({required this.singleImage});

  @override
  _ViewReportPageState createState() => _ViewReportPageState(singleImage);
}

class _ViewReportPageState extends State<ViewReportPage> {
  String singleImage;
  _ViewReportPageState(this.singleImage);
  final _controller = new PageController();
  int currentPage=0;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF08364B) ,
        title: Text('View Report'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: PhotoView.customChild(
                customSize: Size(360,360),
                child: Container(
                  height: 300,
                  child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    child: Image.network(singleImage, fit: BoxFit.contain),
                    ),
                  ),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                // imageProvider: NetworkImage(singleImage),
              )
            ),
          ),
        ],
      ),
    );
  }
}
