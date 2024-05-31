import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/inspection_form.dart';
import 'package:pcbapp/ServiceVO/InspectionTeamDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapturePhoto extends StatefulWidget {
  const CapturePhoto({Key? key}) : super(key: key);

  @override
  State<CapturePhoto> createState() => _CapturePhotoState();
}

class _CapturePhotoState extends State<CapturePhoto> {
   CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String? videoPath;
  bool _isTorchOn = false;
  int? selectedCameraIdx;
   String? token, domain;
   List<InspectionTeamDto>? inspectionList;
   bool loading = true;
   int? seatAllotId;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<XFile>? cameraImages = []; // Initialize cameraImages list

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    getInspectionList();
    // cameraImages!.clear();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }
   Future<void> _initializeCamera() async {
     _cameras = await availableCameras();

     if (_cameras != null && _cameras!.isNotEmpty) {
       _cameraController = CameraController(_cameras![0], ResolutionPreset.max);
       try {
         await _cameraController!.initialize();
         if (mounted) {
           setState(() {}); // Ensure that setState is called only if the widget is still mounted
         }
       } catch (e) {
         print('Error initializing camera: $e');
       }
     } else {
       print("No cameras available");
     }
   }

   @override
  Widget build(BuildContext context) {
    if ( _cameraController != null) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(_cameraController!),
            ),
            Positioned(
              bottom: 2,
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: cameraImages!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Image.file(File(cameraImages![index].path)),
                        ),
                        Positioned(
                          top: 0,
                          left: 80,
                          right: 5,
                          bottom: 120,
                          child:IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                cameraImages!.removeAt(index); // Remove image from the list
                              });
                            },
                          )
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child:ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
            return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _toggleTorch();
                  },
                  icon: Icon(
                    _isTorchOn ? Icons.flash_off_rounded : Icons.flash_on,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _capturePhoto();
                  },
                  icon: const Icon(
                    CupertinoIcons.circle,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.done_outline_rounded,
                    color: Colors.black,
                    size: 15,
                  ),
                  onPressed: () {
                    _cameraController!.setFlashMode(FlashMode.off);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InspectionForm(
                              cameraImages: cameraImages,inspectionId: inspectionList![index].inspectionId!.id,
                            )));
                  },
                ),
              ],
            );
          },)
        ),
      );
    } else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

   Future<String> getInspectionList() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     token = prefs.getString('token');
     domain = prefs.getString('domain');
     seatAllotId = prefs.getInt('seatUserAllottedId');
     Map<String, String> headers = {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization': 'Bearer $token'
     };
     var inspectionRes = await API.getInspectionList(headers, seatAllotId!);
     inspectionList = (json.decode(inspectionRes.body) as List)
         .map((i) => InspectionTeamDto.fromJson(i))
         .toList();

     setState(() {
       if(inspectionList!=null) {
         loading = false;
       }
     });
     return "Success";
   }

   Future<void> _toggleTorch() async {
    if (_isTorchOn) {
      await _cameraController!.setFlashMode(FlashMode.off);
      setState(() {
        _isTorchOn = false;
      });
    } else {
      await _cameraController!.setFlashMode(FlashMode.torch);
      setState(() {
        _isTorchOn = true;
      });
    }
  }

  Future<void> _capturePhoto() async {
    try {
      if (_cameraController!.value.isInitialized /*&& _cameraController != null*/) {
        XFile picture = await _cameraController!.takePicture();
        setState(() {
          cameraImages!.add(picture); // Add captured picture to the list
        });
        print(cameraImages!.length);
      } else {
        print("error");
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }
}
