import 'package:flutter/material.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.callback,
      required this.image,
      required this.name,
      required this.exp,
      required this.city,
      required this.sortName,
      required this.serviceId})
      : super(key: key);

  final VoidCallback callback;
  final AnimationController animationController;
  final Animation<double> animation;
  final String image;
  final String name;
  final String exp;
  final String city;
  final String sortName;
  final String serviceId;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  height: 200,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF032737),
                            image: DecorationImage(
                                image: NetworkImage("https://docoappo27.000webhostapp.com/doctor/$image"), fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF032737).withOpacity(0.7),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0)
                            ]),
                      )),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(sortName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(exp,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(city,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: Color(0xFF032737),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF032737).withOpacity(0.7),
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 10.0)
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
