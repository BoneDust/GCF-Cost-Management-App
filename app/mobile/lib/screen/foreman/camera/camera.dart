import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => new _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
//    if (!controller.value.isInitialized) {
//    }
//    return new AspectRatio(
//        aspectRatio:
//        controller.value.aspectRatio,
//        child: new CameraPreview(controller));
//  }
}
