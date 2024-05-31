import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pcbapp/ServiceVO/ApplicationDetailsDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Submitted_App.dart';

// ignore: missing_return
Future<ApplicationDetailsDto?> fetchApplications(int? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, String> headers = {
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  try {
    var response = await API.getApplicationInfo(headers, id.toString());

    if (response.statusCode == 200) {
      return ApplicationDetailsDto.fromJson(jsonDecode(response.body));

      // ApplicationDetailsDto data = convert.jsonResponse;
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {

  }
}

// ignore: must_be_immutable
class ApplicationInfo extends StatefulWidget {
  int? id;

  ApplicationInfo({this.id});

  @override
  _ApplicationInfoState createState() => _ApplicationInfoState();
}

class _ApplicationInfoState extends State<ApplicationInfo> {
  late Future<ApplicationDetailsDto?> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchApplications(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: (){
              NavigateToBackPage();
            },
          ),
          title: Text("Application ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 0,
              )),

        ),
        /*drawer: Drawer(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(3, 10, 30, 31)),
              Row(
                children: [

                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/Icon.png"),
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Column(
                    children: [
                      Text('USERNAME'),
                      Text('Usergmail@gmail.com'),
                    ],
                  )
                ],
              ),
              LineDrawerList(),
              DrawerList("Notifications", Icons.notifications),
              LineDrawerList(),
              DrawerList("Settings", Icons.settings),
              LineDrawerList(),
              DrawerList("Help", Icons.help),
              LineDrawerList(),
              DrawerList("Logout", Icons.transit_enterexit),
              LineDrawerList(),
            ],
          ),
        ),*/
        body: Container(
          child: SingleChildScrollView(
            child: Container(
                child: FutureBuilder<ApplicationDetailsDto?>(
                  future: fetchApplications(widget.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 40,
                                      width: double.infinity,

                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  //color: Colors.blue,
                                  borderRadius:
                                  BorderRadius.circular(15.0),
                                ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('APPLICATION NO : ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          (snapshot.data!.id.toString() != null)
                                              ? Text(
                                            snapshot.data!.id.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ):Text('No data')
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                     Padding(
                       padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5),
                       child: Card(
                         color: Colors.white,
                         child: Padding(
                           padding: const EdgeInsets.only(left: 8.0,right: 8,top: 20,bottom: 20),
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Establishment Id :',
                                         style: TextStyle(
                                             fontSize: 15, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ?Expanded(
                                       flex: 6,                            child: Text(
                                       snapshot.data!.establishmentId!.id
                                           .toString(),
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 // thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,                             child: Text(
                                       'Establishment Type :',
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black),
                                     ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(
                                       flex: 6,                                 child: Text(
                                       snapshot.data!.establishmentId!
                                           .establishmentType ==""?"---":
                                       snapshot.data!.establishmentId!
                                           .establishmentType!,
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,                       child: Text(
                                       'Industry Name :',
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black),
                                     ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId !=
                                         null)
                                         ?Expanded(
                                       flex: 6,                                 child: Text(snapshot
                                         .data!.establishmentId!.industryName ==""?"---":
                                       snapshot
                                           .data!.establishmentId!.industryName!,
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Address :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(
                                       flex: 6,                               child: Text(snapshot.data!.establishmentId!.address ==""?"---":
                                       snapshot.data!.establishmentId!.address!,
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,

                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Pin Code :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(
                                       flex: 6,
                                       child: Text( snapshot.data!.establishmentId!.pincode ==""?"---":
                                         snapshot.data!.establishmentId!.pincode!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,                                child: Text(
                                       'State Name :',
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black),
                                     ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(flex: 6,

                                       child: Text( snapshot.data!.establishmentId!.district!
                                           .stateId!.stateName ==""?"---":
                                         snapshot.data!.establishmentId!.district!
                                             .stateId!.stateName!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,                                child: Text(
                                       'Village Id :',
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black),
                                     ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId!=
                                         null)
                                         ? Expanded(
                                       flex: 6,                             child: Text(snapshot.data!.establishmentId!.village!.id ==""?"---":
                                       snapshot.data!.establishmentId!.village!.id
                                           .toString(),
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,                                child: Text(
                                       'Industry Status :',
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black),
                                     ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(
                                       flex: 6,                               child: Text( snapshot
                                         .data!.establishmentId!.industryStatus =="" || snapshot
                                         .data!.establishmentId!.industryStatus =="0"?"---":
                                       snapshot
                                           .data!.establishmentId!.industryStatus!,
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Commisioning month :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(
                                       flex: 6,
                                       child: Text(snapshot.data!.establishmentId!
                                           .commissioningMonth == ""?"---":
                                         snapshot.data!.establishmentId!
                                             .commissioningMonth!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Commisioning year :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(flex: 6,
                                       child: Text(snapshot.data!.establishmentId!
                        .commissioningYear! ==""?"---":
                                         snapshot.data!.establishmentId!
                                             .commissioningYear!
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Cost of land :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null && snapshot.data!.establishmentId!.costOfLand !=null)
                                         ? Expanded(flex: 6,
                                       child: Text(snapshot.data!.establishmentId!.costOfLand ==""?"---":
                                         snapshot.data!.establishmentId!.costOfLand
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Cost of building :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId !=
                                         null && snapshot
                                         .data!.establishmentId!.costOfBuilding !=null)
                                         ? Expanded(flex: 6,
                                       child: Text(
                    snapshot
                        .data!.establishmentId!.costOfBuilding == ""?"---":
                                         snapshot
                                             .data!.establishmentId!.costOfBuilding
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Cost of plant :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(flex: 6,
                                       child: Text(snapshot.data!.establishmentId!.costOfPlant ==""?"---":
                                         snapshot.data!.establishmentId!.costOfPlant
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Capital investment :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(flex: 6,
                                       child: Text( snapshot.data!.establishmentId!
                        .capitalInvestment ==""?"---":
                                         snapshot.data!.establishmentId!
                                             .capitalInvestment
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               // Divider(
                               //   thickness: 1,
                               // ),
                               // Padding(
                               //   padding: const EdgeInsets.fromLTRB(17, 1, 1, 1),
                               //   child: Row(
                               //     children: [
                               //       Text(
                               //         'Industry scale :',
                               //         style: TextStyle(
                               //             fontSize: 15, color: Colors.black),
                               //       ),
                               //       SizedBox(
                               //         width: 10,
                               //       ),
                               //        (snapshot
                               //               .data.establishmentId.industryScale !=
                               //           null)
                               //       ?  Text(
                               //           snapshot
                               //               .data.establishmentId.industryScale,
                               //           style: TextStyle(
                               //               fontSize: 15, color: Colors.black),
                               //         ):Text('No data')
                               //     ],
                               //   ),
                               // ),
                               // Divider(
                               //   thickness: 1,
                               // ),
                               // Padding(
                               //   padding: const EdgeInsets.fromLTRB(17, 1, 1, 1),
                               //   child: Row(
                               //     children: [
                               //       Text(
                               //         'Management :',
                               //         style: TextStyle(
                               //             fontSize: 15, color: Colors.black),
                               //       ),
                               //       SizedBox(
                               //         width: 10,
                               //       ),
                               //        (snapshot
                               //               .data.establishmentId.management !=
                               //           null)
                               //         ?Text(
                               //           snapshot.data.establishmentId.management,
                               //           style: TextStyle(
                               //               fontSize: 15, color: Colors.black),
                               //         ):Text('No data')
                               //     ],
                               //   ),
                               // ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Phone No :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(
                                       flex: 6,
                                       child: Text(snapshot.data!.establishmentId!.phoneNo ==""?"---":
                                         snapshot.data!.establishmentId!.phoneNo
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Fax No :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(
                                       flex: 6,                               child: Text(  snapshot.data!.establishmentId!.faxNo ==""?"---":
                                       snapshot.data!.establishmentId!.faxNo
                                           .toString(),
                                       style: TextStyle(
                                           fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'E-mail :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId !=
                                         null)
                                         ? Expanded(
                                       flex: 6,
                                       child: Text(
                                         snapshot.data!.establishmentId!.email == ""? "---":
                                         snapshot.data!.establishmentId!.email!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Cess status :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId !=
                                         null && snapshot
                                         .data!.establishmentId!.cessStatus !=null)
                                         ? Expanded(flex: 6,
                                       child: Text(
                                         snapshot.data!.establishmentId!.cessStatus! ==""? "---":
                                         snapshot.data!.establishmentId!.cessStatus!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(flex: 5,
                                       child: Text(
                                         'Occupier Name :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId !=
                                         null)
                                         ? Expanded(flex: 6,
                                       child: Text(
                                         snapshot
                                             .data!.establishmentId!.occupierName! == ""?"---":
                                         snapshot
                                             .data!.establishmentId!.occupierName!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Occupier Address :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ? Expanded(
                                       flex: 6,
                                       child: Text(
                                         snapshot
                                             .data!.establishmentId!.occupierAddress! == ""?"---":
                                         snapshot
                                             .data!.establishmentId!.occupierAddress!,
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               // Divider(
                               //   thickness: 1,
                               // ),
                               // Padding(
                               //   padding: const EdgeInsets.fromLTRB(17, 1, 1, 1),
                               //   child: Row(
                               //     children: [
                               //       Text(
                               //         'Nationality :',
                               //         style: TextStyle(
                               //             fontSize: 15, color: Colors.black),
                               //       ),
                               //       SizedBox(
                               //         width: 10,
                               //       ),
                               //        (snapshot
                               //               .data.establishmentId !=
                               //           null)
                               //       ?  Text(
                               //           snapshot.data.establishmentId.nationality,
                               //           style: TextStyle(
                               //               fontSize: 15, color: Colors.black),
                               //         ):Text('No data')
                               //     ],
                               //   ),
                               // ),
                               Divider(
                                 thickness: 1,
                               ),
                               // Padding(
                               //   padding: const EdgeInsets.fromLTRB(17, 1, 1, 1),
                               //   child: Row(
                               //     children: [
                               //       Text(
                               //         'Occupier Office Address :',
                               //         style: TextStyle(
                               //             fontSize: 15, color: Colors.black),
                               //       ),
                               //       SizedBox(
                               //         width: 10,
                               //       ),
                               //        (snapshot.data.establishmentId
                               //                !=
                               //           null)
                               //       ?  Text(
                               //           snapshot.data.establishmentId
                               //               .occupierOfficeAddress,
                               //           style: TextStyle(
                               //               fontSize: 15, color: Colors.black),
                               //         ):Text('No data')
                               //     ],
                               //   ),
                               // ),
                               // Divider(
                               //   thickness: 1,
                               // ),
                               Padding(
                                 padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Occupier phone no :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot.data!.establishmentId
                                         !=
                                         null)
                                         ?  Expanded(flex: 6,
                                       child: Text( snapshot
                        .data!.establishmentId!.occupierPhoneNo ==""?"---":
                                         snapshot
                                             .data!.establishmentId!.occupierPhoneNo
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                               Divider(
                                 thickness: 1,
                               ),
                               Padding(
                                 padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       flex: 5,
                                       child: Text(
                                         'Occupier Fax no :',
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     (snapshot
                                         .data!.establishmentId !=
                                         null)
                                         ?  Expanded(
                                       flex: 6,
                                       child: Text(
                                       snapshot
                                           .data!.establishmentId!.occupierFaxNo ==""? "---":
                                         snapshot
                                             .data!.establishmentId!.occupierFaxNo
                                             .toString(),
                                         style: TextStyle(
                                             fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                                       ),
                                     ):Expanded(
                                         flex: 6,
                                         child: Text('---'))
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                )),
          ),
        ));
  }

  void NavigateToBackPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmittedApplication(),
        ));
  }

// Future<bool> _onbackpressed1() {
//   return Navigator.pop(context);
// }
}
