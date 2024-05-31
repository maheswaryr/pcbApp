import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pcbapp/Activity/capture.dart';
import 'package:pcbapp/Activity/inspection_list.dart';
import 'package:pcbapp/ServiceVO/ActDetailsDto%20.dart';
import 'package:pcbapp/ServiceVO/ApplicationDetailsDto.dart';
import 'package:pcbapp/ServiceVO/DistrictSetupDto.dart';
import 'package:pcbapp/ServiceVO/InspectionDetailsDto.dart';
import 'package:pcbapp/ServiceVO/SeatUserAllotedDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';

class InspectionForm extends StatefulWidget {
  int? inspectionId;
  final List<XFile>? cameraImages;
  InspectionForm({this.inspectionId,this.cameraImages});

  @override
  _InspectionFormState createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionForm> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<String> capturedMedia = [];
// ignore: deprecated_member_use
  List<Asset> images = <Asset>[];
  // ignore: unused_field
  String? _error = 'No Error Dectected';
  DateTime? inspectionDate;
  final _formKey = GlobalKey<FormState>();
  ApplicationDetailsDto? applicationId;
  TextEditingController inspectionNo = TextEditingController();
  SeatUserAllotedDto? initiatedBy;
  SeatUserAllotedDto? verifiedBy;
  SeatUserAllotedDto? approvedBy;
  SeatUserAllotedDto? closedBy;
  SeatUserAllotedDto? draftReportApprovedBy;
  DistrictSetupDto? district;
  ActDetailsDto? consentType;
  TextEditingController establishmentType = TextEditingController();
  TextEditingController industryName = TextEditingController();
  TextEditingController villageName = TextEditingController();
  TextEditingController management = TextEditingController();
  TextEditingController hierarchyName = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  int? appId;
  String? initiatedOn,
      verifiedOn,
      approvedOn,
      remarks,
      effort,
      findings,
      actionTaken,
      fileFileName,
      status,
      sequenceNo,
      draftReport,
      draftReportApprovedOn,
      revisedStatus;
  bool loading = true;
  InspectionDetailsDto inspectionDetailsDto=InspectionDetailsDto();
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Position _currentPosition;
  String? _currentAddress;
  String? _currentPosition;
  String? lat;
  String? long;
  late Geolocator geolocator;
// ignore: deprecated_member_use
  double? latitude;
  double? longitude;
  File? _image;
  bool uploadVisible=false;
  late List<CameraDescription>? cameras;

  Future<void> capturePhotos() async {
    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/images/';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${DateTime.now()}.png';

    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      XFile picture = await _controller.takePicture();
      await File(picture.path).copy(filePath);
    } catch (e) {
      print(e);
    }
  }

  Future<void> startVideoRecording() async {
    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/videos/';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${DateTime.now()}.mp4';

    if (!_controller.value.isInitialized) {
      return null;
    }

    if (_controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await _controller.startVideoRecording();
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await _controller.stopVideoRecording();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getInspectionDetails();
    _getCurrentLocation();
    registerPlatformInstance();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> loadAssets() async {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    const AlbumSetting albumSetting = AlbumSetting(
      fetchResults: {
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumFavorites,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.album,
          subtype: PHAssetCollectionSubtype.albumRegular,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumSelfPortraits,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumPanoramas,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumVideos,
        ),
      },
    );

    const SelectionSetting selectionSetting = SelectionSetting(
      min: 0,
      max: 3,
      unselectOnReachingMax: true,
    );
    const DismissSetting dismissSetting = DismissSetting(
      enabled: true,
      allowSwipe: true,
    );
    final ThemeSetting themeSetting = ThemeSetting(
      backgroundColor: colorScheme.background,
      selectionFillColor: colorScheme.primary,
      selectionStrokeColor: colorScheme.onPrimary,
      previewSubtitleAttributes: const TitleAttribute(fontSize: 12.0),
      previewTitleAttributes: TitleAttribute(
        foregroundColor: colorScheme.primary,
      ),
      albumTitleAttributes: TitleAttribute(
        foregroundColor: colorScheme.primary,
      ),
    );
    const ListSetting listSetting = ListSetting(
      spacing: 5.0,
      cellsPerRow: 4,
    );
    final CupertinoSettings iosSettings = CupertinoSettings(
      fetch: const FetchSetting(album: albumSetting),
      theme: themeSetting,
      selection: selectionSetting,
      dismiss: dismissSetting,
      list: listSetting,
    );

    try {
      resultList = await MultiImagePicker.pickImages(
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          doneButton:
          UIBarButtonItem(title: 'Confirm', tintColor: colorScheme.primary),
          cancelButton:
          UIBarButtonItem(title: 'Cancel', tintColor: colorScheme.primary),
          albumButtonColor: colorScheme.primary,
          settings: iosSettings,
        ),
        materialOptions: MaterialOptions(
          actionBarColor: colorScheme.surface,
          actionBarTitleColor: colorScheme.onSurface,
          statusBarColor: colorScheme.surface,
          actionBarTitle: "Select Photo",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: colorScheme.primary,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF002D68),
            title: Text('Inspection Form',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0,
                )),
            leading: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InspectionList()));
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body:/*loading? Center(child: CircularProgressIndicator()):*/
          RefreshIndicator(
            onRefresh: () => Future.sync(() {
              getInspectionDetails();
            }),
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue[900],
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Application Id : ' + widget.inspectionId.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: establishmentType,
                    decoration: _entryField('Establishment Type *'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: industryName,
                    decoration: _entryField('Industry Name *'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                    controller: villageName,
                    decoration: _entryField('Village Name *'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: management,
                    decoration: _entryField('Management'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    // readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: inspectionNo,
                    decoration: _entryField('Inspection Number'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can\'t be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: hierarchyName,
                    decoration: _entryField('Hierarchy Name'),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Container(
                                            child:Text('Latitude : ' + latitude.toString()),
                                        ),
                                      ),Expanded(
                                        child: Container(
                                            child:Text('Longitude : ' + longitude.toString()),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                Text("Findings and Upload Documents",style: TextStyle(fontSize: 20,color: Color(0xFF002D68),fontWeight: FontWeight.w500 ),),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 500),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Center(child: Text("Upload Documents", style: TextStyle(fontSize: 16))),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: TextFormField(
                                controller: findingsController,
                                style: TextStyle(fontSize: 12),
                                minLines: 1,
                                maxLines: 200,
                                decoration: InputDecoration(
                                  labelText: "Findings",
                                  hintText: "Findings",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
                                  helperStyle: TextStyle(color: Colors.black, fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            widget.cameraImages != null && widget.cameraImages!.isNotEmpty? Container(
                              child:SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: widget.cameraImages?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Stack(
                                        children:[
                                          Container(
                                            width: 100,
                                            height: 150,
                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                            child: Image.file(File(widget.cameraImages![index].path)),
                                          ),
                                          Positioned(
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
                                                    widget.cameraImages!.removeAt(index); // Remove image from the list
                                                  });
                                                },
                                              )
                                          )
                                        ]
                                    );
                                  },
                                ),
                              ),

                            ):Center(child: Text('No picture available',style: TextStyle(fontSize: 14,color: Color(0xFFC80808)),)),
                            SizedBox(height: 10.0),
                            Center(
                              child: SizedBox(
                                width: 150,
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                     backgroundColor: Color(0xFF007f38), // Change the text color here
                                    ),
                                    onPressed: () async {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CapturePhoto()));
                                    },
                                    child: Text("Capture Photo",style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _saveButton(context),
                  SizedBox(
                    height: 20,
                  ),
                  // _uploadButton(context,),
                ]),
              ),
            )),
          ),
      ),
    );
  }

  _entryField(String? title) {
    return InputDecoration(
        labelText: title,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)));
  }

  Widget _saveButton(BuildContext context) {
    return InkWell(
        onTap: () async {
         // _getCurrentLocation();
          // Fluttertoast.showToast(
          //    // msg: 'Latitude :' + lat + ', ' + 'Longitude :' + long,
          //    msg: 'SUccess',
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.blueGrey[300],
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          if (_formKey.currentState!.validate()) {
            // saveInspectionForm();
            uploadDocumentsAndFindings(widget.inspectionId!);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color:  Color(0xFF002D68),
                    offset: Offset(2,4),
                    spreadRadius: 2)
              ],),
          child: Text(
            'SAVE',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ));
  }

/*
  Widget _uploadButton(BuildContext context,) {
    return InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
           uploadDocumentsModal(context,widget.cameraImages);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color:  Color(0xFF002D68),
                    offset: Offset(2, 4),
                    spreadRadius: 2)
              ],),
          child: Text(
            'FINDINGS AND UPLOAD DOCUMENTS',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ));
  }

  uploadDocumentsModal(BuildContext context, List<XFile>? cameraImages) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              constraints: BoxConstraints(maxHeight: 500),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(child: Text("Upload Documents", style: TextStyle(fontSize: 16))),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        minLines: 1,
                        maxLines: 200,
                        decoration: InputDecoration(
                          labelText: "Findings",
                          hintText: "Findings",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
                          helperStyle: TextStyle(color: Colors.black, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black38),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star,
                              size: 20.0,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    widget.cameraImages != null && widget.cameraImages!.isNotEmpty? Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.cameraImages!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: 150,
                              height: 150,
                              child: Image.file(File(widget.cameraImages![index].path)));
                        },),
                    ):Text('No picture available'),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CapturePhoto()));
                         */
/* try {
                            await _initializeControllerFuture;

                            final directory = await getTemporaryDirectory();
                            final imagePath = '${directory.path}/${DateTime.now()}.png';

                            XFile picture = await _controller.takePicture();

                            final File savedImage = File(picture.path);
                            await savedImage.copy(imagePath);

                            // Display the image
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath)),
                            );
                          } catch (e) {
                            print("Error: $e");
                          }*//*

                        },
                        child: Text("Capture Photo"),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement video capture logic
                        },
                        child: Text("Capture Video"),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement document upload logic
                        },
                        child: Text("Upload Document"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
*/

  buttonText(String s) {
    return Text(s, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold));
  }
  ButtonStyle saveButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF01458E),
        foregroundColor: Color(0xFF01458E).withOpacity(0.1),
        elevation: 3,
      );

  Future<bool> _onBackPressed() async {
    return await Navigator.pushReplacement(this.context,
        MaterialPageRoute(builder: (context) => InspectionList()));
  }

  // ignore: unused_element
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Date of commencement',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != inspectionDate)
      setState(() {
        inspectionDate = picked;
      });
  }

  void saveInspectionForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    InspectionDetailsDto inspectionObj = new InspectionDetailsDto();
    inspectionObj.id = widget.inspectionId;
    inspectionObj.applicationId = new ApplicationDetailsDto();
    inspectionObj.applicationId = applicationId;
    inspectionObj.inspectionNumber=inspectionNo.text;
    inspectionObj.initiatedBy = new SeatUserAllotedDto();
    inspectionObj.initiatedBy = initiatedBy;
    inspectionObj.initiatedOn = initiatedOn;
    inspectionObj.verifiedBy = new SeatUserAllotedDto();
    inspectionObj.verifiedBy = verifiedBy;
    inspectionObj.verifiedOn = verifiedOn;
    inspectionObj.approvedBy = new SeatUserAllotedDto();
    inspectionObj.approvedBy = approvedBy;
    inspectionObj.approvedOn = approvedOn;
    inspectionObj.closedBy = new SeatUserAllotedDto();
    inspectionObj.closedBy = closedBy;
    inspectionObj.draftReportApprovedBy = new SeatUserAllotedDto();
    inspectionObj.draftReportApprovedBy = draftReportApprovedBy;
    inspectionObj.district = new DistrictSetupDto();
    inspectionObj.district = district;
    inspectionObj.consentType = new ActDetailsDto();
    inspectionObj.consentType = consentType;
    inspectionObj.remarks = remarks;
    inspectionObj.effort = effort;
    inspectionObj.findings = findings;
    inspectionObj.actionTaken = actionTaken;
    inspectionObj.fileFileName = fileFileName;
    inspectionObj.status = status;
    inspectionObj.sequenceNo = int.parse(sequenceNo!);
    inspectionObj.draftReport = draftReport;
    // inspectionObj.revisedStatus = revisedStatus;
    inspectionObj.gisLatitude = latitude.toString();
    inspectionObj.gisLongitude = longitude.toString();
    String? encodedData = convert.jsonEncode(inspectionObj);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await API.updateInspectionDetails(encodedData, headers);
      // ignore: unused_local_variable
      InspectionDetailsDto inspectionRes = InspectionDetailsDto.fromJson(convert.jsonDecode(response.body));
      if (response.statusCode == 200) {
//        prefs.setString('inspectionRes', json.encode(inspectionRes));
        Fluttertoast.showToast(
            msg: "SAVED SUCCESSFULLY!!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InspectionList()));
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[300],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  void uploadDocumentsAndFindings(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    InspectionDetailsDto inspectionObj = new InspectionDetailsDto();
    String encodedData = await convert.jsonEncode(inspectionDetailsDto);
    List<File>? files = widget.cameraImages?.map((xFile) => File(xFile.path)).toList();
    if (files != null) {
      var response = await API.uploadDocumentsAndFindings(encodedData, token!, files,findingsController.text,widget.inspectionId);
      if (response.body != null) {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "SAVED SUCCESSFULLY!!!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey[300],
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }

/*
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      if (_currentPosition != null) {
        List<Placemark> p = await geolocator!.placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude);

        Placemark place = p[0];

        setState(() {
          _currentAddress =
          "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        print("Current position is null.");
      }
    } catch (e) {
      print(e);
    }
  }
*/

  Future<void> requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print('Error getting location:');
    }
  }


  void registerPlatformInstance() {
    if (Platform.isAndroid) {
      GeolocatorAndroid.registerWith();
    } else if (Platform.isIOS) {
      GeolocatorApple.registerWith();
    }
  }

  /*Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }
*/

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        print("No permission, requesting one");
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
      print("Found permission to get location");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;

    } catch (e) {
      print(e);
    }
  }

  Future<void> getLocation() async {
    await _getCurrentLocation(); // Call your method to get current location
  }
  Future <void> getInspectionDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await API.getInspectionDetails(headers, widget.inspectionId!);
    if (response.statusCode == 200) {
      inspectionDetailsDto = InspectionDetailsDto.fromJson(convert.jsonDecode(response.body));
      setState(() {
        loading = false;
        applicationId = inspectionDetailsDto.applicationId;
        initiatedBy = inspectionDetailsDto.initiatedBy;
        verifiedBy = inspectionDetailsDto.verifiedBy;
        approvedBy = inspectionDetailsDto.approvedBy;
        closedBy = inspectionDetailsDto.closedBy;
        draftReportApprovedBy = inspectionDetailsDto.draftReportApprovedBy;
        district = inspectionDetailsDto.district;
        consentType = inspectionDetailsDto.consentType;
        establishmentType.text =
        inspectionDetailsDto.applicationId!.establishmentId!.establishmentType!;
        industryName.text =
        inspectionDetailsDto.applicationId!.establishmentId!.industryName!;
        villageName.text =
        inspectionDetailsDto.applicationId!.establishmentId!.village!.villageName!;
        management.text =
        inspectionDetailsDto.applicationId!.establishmentId!.management!;
        inspectionDetailsDto.inspectionNumber!=null?inspectionNo.text = inspectionDetailsDto.inspectionNumber!:"--0000--";
        hierarchyName.text = inspectionDetailsDto.applicationId!.heldBy!.hierarchyName!;
        initiatedOn = inspectionDetailsDto.initiatedOn;
        verifiedOn = inspectionDetailsDto.verifiedOn;
        approvedOn = inspectionDetailsDto.approvedOn;
        remarks = inspectionDetailsDto.remarks;
        effort = inspectionDetailsDto.effort;
        findings = inspectionDetailsDto.findings;
        actionTaken = inspectionDetailsDto.actionTaken;
        fileFileName = inspectionDetailsDto.fileFileName;
        status = inspectionDetailsDto.status;
        sequenceNo = inspectionDetailsDto.sequenceNo.toString();
        draftReport = inspectionDetailsDto.draftReport;
        draftReportApprovedOn = inspectionDetailsDto.draftReportApprovedOn;
      });
    }
  }

  Future <void> setInspectionForm()async {
    applicationId = inspectionDetailsDto.applicationId;
    initiatedBy = inspectionDetailsDto.initiatedBy;
    verifiedBy = inspectionDetailsDto.verifiedBy;
    approvedBy = inspectionDetailsDto.approvedBy;
    closedBy = inspectionDetailsDto.closedBy;
    draftReportApprovedBy = inspectionDetailsDto.draftReportApprovedBy;
    district = inspectionDetailsDto.district;
    consentType = inspectionDetailsDto.consentType;
    establishmentType.text =
        inspectionDetailsDto.applicationId!.establishmentId!.establishmentType!;
    industryName.text =
        inspectionDetailsDto.applicationId!.establishmentId!.industryName!;
    villageName.text =
        inspectionDetailsDto.applicationId!.establishmentId!.village!.villageName!;
    management.text =
        inspectionDetailsDto.applicationId!.establishmentId!.management!;
    inspectionDetailsDto.inspectionNumber!=null?inspectionNo.text = inspectionDetailsDto.inspectionNumber!:"--0000--";
    hierarchyName.text = inspectionDetailsDto.applicationId!.heldBy!.hierarchyName!;
    initiatedOn = inspectionDetailsDto.initiatedOn;
    verifiedOn = inspectionDetailsDto.verifiedOn;
    approvedOn = inspectionDetailsDto.approvedOn;
    remarks = inspectionDetailsDto.remarks;
    effort = inspectionDetailsDto.effort;
    findings = inspectionDetailsDto.findings;
    actionTaken = inspectionDetailsDto.actionTaken;
    fileFileName = inspectionDetailsDto.fileFileName;
    status = inspectionDetailsDto.status;
    sequenceNo = inspectionDetailsDto.sequenceNo.toString();
    draftReport = inspectionDetailsDto.draftReport;
    draftReportApprovedOn = inspectionDetailsDto.draftReportApprovedOn;
    // revisedStatus = inspectionDetailsDto!.revisedStatus;
  }
}
