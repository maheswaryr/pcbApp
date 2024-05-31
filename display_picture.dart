import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final List<XFile>? cameraImages;

  DisplayPictureScreen(this.cameraImages);

  @override
  Widget build(BuildContext context) {
    if (cameraImages != null && cameraImages!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Display the Picture')),
        body: ListView.builder(
          itemCount: cameraImages!.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(
              width: 150,
              height: 150,
              child: Image.file(File(cameraImages![index].path)));
        },), // Use path property to get the file path
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('No Picture')),
        body: Center(child: Text('No picture available')),
      );
    }
  }
}
