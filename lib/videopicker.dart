import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';



class VideoPickerWidget extends StatefulWidget {






  @override
  _VideoPickerWidgetState createState() => _VideoPickerWidgetState();
}

class _VideoPickerWidgetState extends State<VideoPickerWidget> {


  File videoFile;


//Video from Gallery
  _videoPic()async{
    File theVid = await ImagePicker.pickVideo(

      source: ImageSource.gallery
    );

    if(theVid != null) {
      setState(() {
        videoFile = theVid;
        print("set");
      });
    }

  }

  //Video from camera
  _record()async{
    File theVid = await ImagePicker.pickVideo(

        source: ImageSource.camera
    );

    if(theVid != null) {
      setState(() {
        videoFile = theVid;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.brown,
              height: MediaQuery.of(context).size.height*(70/100),
              width: MediaQuery.of(context).size.width*(100/100),
              child: videoFile == null?Center(
                child: Icon(Icons.videocam,color: Colors.red,size: 50.0),
              ): FittedBox(
                fit: BoxFit.contain,
                child: mounted?Chewie(
                  controller: ChewieController(
                    videoPlayerController: VideoPlayerController.file(videoFile)..initialize(),
                    aspectRatio: 3/2,
                    autoPlay: false,
                    looping: false,
                  ),
                ):Container(),
              ),

            ),
            FlatButton(
              child: Text("video"),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {_videoPic();},
            ),
            
            FlatButton(
              child: Text("record"),
              onPressed: () {_record();},
            )
          ],
        ),
      ),
    );
  }
}
