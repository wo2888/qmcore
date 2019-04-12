import 'package:flutter/material.dart';
import 'dart:async';

class QMSplashScreen extends StatefulWidget {
  final String appName; // 应用名
  final String description; // 应用描述
  final Color background; // 欢迎页面背景色
  final IconData icon; // 图标
  final int duration; // 间隔时间
  // final VoidCallback callback; // 初始化后的回调
  final void Function(BuildContext) callback;

  QMSplashScreen(
      {this.appName = "Fusion3.0",
      this.description = "Fustion3.0 Platform \n  For Everyone",
      this.background = Colors.blueAccent,
      this.icon = Icons.insert_chart,
      this.duration = 2,
      this.callback});

  @override
  _QMSplashScreenState createState() => _QMSplashScreenState();
}

class _QMSplashScreenState extends State<QMSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>{widget.callback(context)});
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
            // decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/images/launch_image.png"),
            //   fit: BoxFit.cover,
            // ),
        // ),
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
                          widget.icon ?? Icons.pie_chart,
                          color: widget.background,
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(widget.appName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold))
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
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(widget.description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)
                    ),
                    FlatButton(
                      onPressed: ()=>widget.callback(context),
                      color: widget.background,
                      child: Text('跳过',
                        style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)
                      ),
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
