import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pcbapp/ServiceVO/EstablishmentDetailsDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';
import 'Submitted_App.dart';
import 'industryHome.dart';

// ignore: must_be_immutable
class EstablishmentList extends StatefulWidget {
  String? userId;

  EstablishmentList({this.userId});

  @override
  _EstablishmentListState createState() => _EstablishmentListState();
}

class _EstablishmentListState extends State<EstablishmentList> {
    late Future<EstablishmentDetailsDto?> futureAlbum;

  @override
  void initState() {
    super.initState();
    fetchEstList(widget.userId!);
  }
    String? token, domain;
    Future<bool> _onBackPressed() async {
      if (domain == "P") {
        return await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        return await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IndHome()));
      }
    }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: _onBackPressed,
              ),
              // leading: Icon(Icons.arrow_back,color: Colors.white,),
              title: Text("Establishment list ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0,
                    color: Colors.white
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
            body: Center(
                child: FutureBuilder<List<EstablishmentDetailsDto>?>(
              future: fetchEstList(widget.userId!),
              builder: (context, snapshot) {
                print("snapshot");
                print(snapshot.data);
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 5.0),
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Center(
                                      child: /*Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child:*/ Card(
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
                                              // onTap: () {
                                              //   Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             ApplicationInfo(
                                              //                 id: snapshot
                                              //                     .data[i].id)),
                                              //   );
                                              // },
                                              child: Container(
                                                  padding: EdgeInsets.only(top: 5.0),

                                                  // height: 160,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 0.0,
                                                        offset: Offset(2.0,
                                                            2.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(children: [
                                                   SizedBox(height: 15,),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              17, 1, 1, 1),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                'Establishment Type :',
                                                                style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight:
                                                                    FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),

                                                          Container(
                                                            child: Container(
                                                                child: (snapshot
                                                                            .data![i]
                                                                            .establishmentType !=
                                                                        null)
                                                                    ? Expanded(
                                                                        flex: 6,
                                                                        child: Text(
                                                                          snapshot
                                                                              .data![
                                                                                  i]
                                                                              .establishmentType!
                                                                              ,
                                                                          style: TextStyle(
                                                                              fontSize: 14.0,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                        ),
                                                                      )
                                                                    : Expanded(
                                                                        flex: 6,
                                                                        child: Text(
                                                                          'Invalid data',
                                                                          style: TextStyle(
                                                                              fontSize: 14.0,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                        ),
                                                                      )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              17, 1, 1, 1),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                'Industry Name :',
                                                                style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight:
                                                                    FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                              child: (snapshot
                                                                          .data![i]
                                                                          .industryName !=
                                                                      null)
                                                                  ? Expanded(
                                                                      flex: 6,
                                                                      child: Text(
                                                                        snapshot
                                                                            .data![i]
                                                                            .industryName!,
                                                                        style: TextStyle(
                                                                            fontSize: 14.0,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                      ),
                                                                    )
                                                                  : Expanded(
                                                                      flex: 6,
                                                                      child: Text(
                                                                        'invalid data',
                                                                        style: TextStyle(
                                                                            fontSize: 14.0,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                      ),
                                                                    ))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              17, 1, 1, 1),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                'District :',
                                                                style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight:
                                                                    FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          (snapshot.data![i]
                                                                      .district!.districtName! !=
                                                                  null)
                                                              ? Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    snapshot
                                                                        .data![i]
                                                                        .district!.districtName!
                                                                        ,
                                                                    style: TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                )
                                                              : Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    'invalid data',
                                                                    style: TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              17, 1, 1, 1),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                'Village:',
                                                                style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight:
                                                                    FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          (snapshot.data![i]
                                                                      .village!.villageName !=
                                                                  null)
                                                              ? Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    snapshot
                                                                        .data![i]
                                                                        .village!.villageName!

                                                                        ,
                                                                    style: TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                )
                                                              : Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    'Invalid data',
                                                                    style: TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight:
                                                                        FontWeight.w300),
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ])),
                                            ),
                                          ));
                                }),
                          )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ))));
  }


  // ignore: missing_return
  Future<List<EstablishmentDetailsDto>?> fetchEstList(String? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    domain = prefs.getString('domain');
    try {
      var response = await API.getEstablishmentList({
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, userId);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((module) => new EstablishmentDetailsDto.fromJson(module))
            .toList();
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print("Error getting users.");
    }
  }
}

