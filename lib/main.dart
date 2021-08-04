import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:timertest/videopicker.dart';
import 'dart:io';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //platform: TargetPlatform.iOS,
      ),
      home: HomeScreen(
      ),
    );
  }
}





class HomeScreen extends StatefulWidget {




  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {


  bool startispressed = true;
  bool resetispressed = true;
  bool stopispressed = true;
  String stoptimetodisplay = "00.00.00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);


  void starttimer(){
    Timer(dur, keeprunning);
  }

  void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inMinutes.toString().padLeft(2, "0") + ":"
          + (swatch.elapsed.inSeconds%60).toString().padLeft(2, "0") + ":"
          + (swatch.elapsed.inMilliseconds%100).toString().padLeft(2, "0");
    });
  }


  void startstopwatch(){
    setState(() {
      stopispressed = false;
      startispressed = true;
    });
    swatch.start();
    starttimer();
  }


  void stopstopwatch(){
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch(){
    setState(() {
      startispressed = true;
      resetispressed = true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }



  Widget stopwatch(){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.topCenter,
              child: Text(stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: stopispressed ? null : stopstopwatch,
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          "Stop",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      RaisedButton(
                        onPressed: resetispressed ? null : resetstopwatch,
                        color: Colors.teal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startispressed ? startstopwatch: null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            VideoPickerWidget(),
            stopwatch(),
          ],
        ),
    );
  }
}
