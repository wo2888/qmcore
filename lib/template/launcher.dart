import 'package:flutter/material.dart';
import 'dart:async';


class QMSplashScreen extends StatefulWidget {
  @override
  _QMSplashScreenState createState() => _QMSplashScreenState();

}

class _QMSplashScreenState extends State<QMSplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:5),() => print("Splash DOne!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.blueAccent,
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(top: 10.0) ,
                        ),
                        Text(
                          "Fusion3.0",
                          style:TextStyle(
                            color:Colors.white, 
                            fontSize:24.0,
                            fontWeight:FontWeight.bold
                            )
                        )
                    ],
                  ),
                ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(padding: EdgeInsets.only(top:20.0),
                      ),
                      Text("Fustion3.0 Platform \n  For Everyone", 
                      style: TextStyle(
                        color: Colors.white, 
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                      )
                      )
                    ],
                    ),
                ),
            ],
            )
        ],
      ),
      );
  }

}

