import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/industryHome.dart';
import 'package:pcbapp/Activity/inspection_form.dart';
import 'package:pcbapp/Activity/pcbHome.dart';
import 'package:intl/intl.dart';
import 'package:pcbapp/ServiceVO/InspectionTeamDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Submitted_App.dart';

// ignore: must_be_immutable
class InspectionList extends StatefulWidget {
  String? userId, allotId;

  InspectionList({this.userId, this.allotId});

  @override
  inspectionListState createState() => inspectionListState();
}

class inspectionListState extends State<InspectionList> {
  String? token, domain;
  List<InspectionTeamDto>? inspectionList;
  bool loading = true;
  int? seatAllotId;

  @override
  void initState() {
    super.initState();
    getPrefs();
      getInspectionList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF002D68),
            title: Text("Inspection List", style: TextStyle(color: Colors.white,fontSize: 22),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _onBackPressed,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 2));
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    loading == true
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xFF002D68),
                              strokeWidth: 2.0,
                            ),
                          )
                        : loading == false
                            ? Container(
                                padding: EdgeInsets.only(top: 5.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: inspectionList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InspectionForm(inspectionId: inspectionList![index].inspectionId!.id,)));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        color: Colors.white,
                                        // shadowColor: Color(0xFF002D68),
                                        // color: Color(0xFFF6FAFD),
                                        elevation: 2,
                                        clipBehavior: Clip.antiAlias,
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0,left: 8,bottom: 4,right: 8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          'Initiated by:',
                                                          style: TextStyle(
                                                              color:Colors.black
                                                                /*  Color(0xFF002D68)*/,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        ),
                                                      ),
                                                    ),
                                                    inspectionList![index]
                                                                .inspectionId!
                                                                .initiatedBy !=
                                                            null
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(
                                                                DateTime.parse(inspectionList![
                                                                            index]
                                                                        .inspectionId!
                                                                        .initiatedOn!)
                                                                    .add(Duration(
                                                                        days: 1)),
                                                              ),
                                                              style: TextStyle(
                                                                  color:Colors.black, /*Color(
                                                                      0xFF002D68),*/
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'No Data',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF002D68),
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          'Inspection Number: ',
                                                          style: TextStyle(
                                                              color:Colors.black
                                                                  /*Color(0xFF002D68)*/,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: inspectionList![
                                                                          index]
                                                                      .inspectionId !=
                                                                  null &&
                                                              inspectionList![
                                                                          index]
                                                                      .inspectionId!
                                                                      .inspectionNumber !=
                                                                  null
                                                          ? Text(
                                                              inspectionList![index].inspectionId!.inspectionNumber!.trim(),
                                                              style: TextStyle(
                                                                  color:Colors.black /*Color(
                                                                      0xFF002D68)*/,
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              'No Data',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF002D68),
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          'Verified by: ',
                                                          style: TextStyle(
                                                              color:Colors.black
                                                                  /*Color(0xFF002D68)*/,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        ),
                                                      ),
                                                    ),
                                                    inspectionList![index]
                                                                .inspectionId!
                                                                .verifiedBy !=
                                                            null
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              inspectionList![index]
                                                                  .inspectionId!
                                                                  .verifiedBy!.user!.userName == null ? "No data" : inspectionList![index]
                                                                  .inspectionId!
                                                                  .verifiedBy!.user!.userName!+
                                                                  " on " +
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .format(DateTime.parse(inspectionList![
                                                                              index]
                                                                          .inspectionId!
                                                                          .verifiedOn!)),
                                                              style: TextStyle(
                                                                  color:Colors.black /*Color(
                                                                      0xFF002D68)*/,
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'No Data',
                                                              style: TextStyle(
                                                                  color:Colors.black /*Color(
                                                                      0xFF002D68)*/,
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          'Approved by: ',
                                                          style: TextStyle(
                                                              color:Colors.black
                                                                 /* Color(0xFF002D68)*/,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        ),
                                                      ),
                                                    ),
                                                    inspectionList![index]
                                                                .inspectionId!
                                                                .approvedBy !=
                                                            null
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              inspectionList![index]
                                                                  .inspectionId!
                                                                  .approvedBy!.user!.userName == null ? "No data" : inspectionList![index]
                                                                  .inspectionId!
                                                                  .approvedBy!.user!.userName! +
                                                                  " on " +
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .format(DateTime.parse(inspectionList![
                                                                              index]
                                                                          .inspectionId!
                                                                          .approvedOn!)),
                                                              style: TextStyle(
                                                                  color:Colors.black /*Color(
                                                                      0xFF002D68),
                                                                  fontSize: 14.0*/,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'No Data',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF002D68),
                                                                  fontSize: 14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Padding(
                                                      //     padding: const EdgeInsets.only(left: 8.0),
                                                      //     child: Text(
                                                      //       'Inspection Status: ',
                                                      //       style: TextStyle(
                                                      //           color:Colors.black
                                                      //               /*Color(0xFF002D68)*/,
                                                      //           fontSize: 14.0,
                                                      //           fontWeight:
                                                      //               FontWeight.w300),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: (inspectionList![
                                                                        index]
                                                                    .inspectionId !=
                                                                null)
                                                            ? (inspectionList![
                                                                            index]
                                                                        .inspectionId!
                                                                        .status ==
                                                                    "I"
                                                                ? Text(
                                                                    "Initiated",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  )
                                                                : inspectionList![
                                                                                index]
                                                                            .inspectionId!
                                                                            .status ==
                                                                        "V"
                                                                    ? Text(
                                                                        "Verified",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Colors
                                                                                .blue,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      )
                                                                    : inspectionList![index]
                                                                                .inspectionId!
                                                                                .status ==
                                                                            "A"
                                                                        ? Text(
                                                                            "Approved",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    14,
                                                                                color:
                                                                                    Colors.green[800],
                                                                                fontWeight: FontWeight.w500),
                                                                          )
                                                                        : inspectionList![index].inspectionId!.status ==
                                                                                "C"
                                                                            ? Text(
                                                                                "Closed",
                                                                                style: TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: Colors.red,
                                                                                    fontWeight: FontWeight.w500),
                                                                              )
                                                                            : Text(
                                                                                'invalid data',
                                                                                style:
                                                                                    TextStyle(color: Colors.black),
                                                                              ))
                                                            : Text(
                                                                'invalid data',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Text('No Drafted Applications')),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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

  Future<bool> _onBackPressed() async {
    if (domain == "P") {
      return await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      return await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IndHome()));
    }
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seatAllotId = prefs.getInt('seatUserAllottedId');
  }
}
