import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pcbapp/Activity/Application_info.dart';
import 'package:pcbapp/ServiceVO/ApplicationDetailsDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';
import 'industryHome.dart';

// ignore: must_be_immutable
class SubmittedApplication extends StatefulWidget {

  @override
  _SubmittedApplicationState createState() => _SubmittedApplicationState();
}

class _SubmittedApplicationState extends State<SubmittedApplication> {
  Future<ApplicationDetailsDto>? futureAlbum;

  bool? loading;
  int? userId, seatId;
  String? userName, email, mobile;

  @override
  void initState() {
    super.initState();
    fetchPrefs();
    fetchSubmittedList();
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _onBackPressed,
            ),
            title: Text("Submitted applications ",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 0,
                )),
          ),
          body: Center(
              child: FutureBuilder<List<ApplicationDetailsDto>?>(
            future: fetchSubmittedList(),
            builder: (context, snapshot) {
              print("snapshot");
              print(snapshot.data);
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: Card(
                          elevation: 2,
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Center(
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0,left: 5,right: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApplicationInfo(
                                                          id: snapshot
                                                              .data![i].id)),
                                            );
                                          },
                                          child: Container(

                                              // height: 160,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                //color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                  /*  blurRadius: 2.0,
                                                    spreadRadius: 0.0,
                                                    offset: Offset(2.0,
                                                        2.0), */// shadow direction: bottom right
                                                  )
                                                ],
                                              ),
                                              child: Column(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 10, 10, 1),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30.0)),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Application no :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: Container(
                                                            child: (snapshot
                                                                        .data![i]
                                                                        .id
                                                                        .toString() !=
                                                                    null)
                                                                ? Expanded(
                                                                    flex: 6,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data![
                                                                              i]
                                                                          .id
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.blue.shade900,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : Expanded(
                                                                    flex: 6,
                                                                    child: Text(
                                                                      '---',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                    ),
                                                                  )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB( 20, 10, 10, 1
                                                        /*  17, 1, 1, 1*/),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Consent type :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: Container(
                                                            child: (snapshot
                                                                        .data![i]
                                                                        .establishmentId !=
                                                                    null)
                                                                ? Expanded(
                                                                    flex: 6,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data![
                                                                              i]
                                                                          .establishmentId!
                                                                          .category!
                                                                          .categoryName!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : Expanded(
                                                                    flex: 6,
                                                                    child: Text(
                                                                      '---',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black),
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
                                                          20, 10, 10, 1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Submitted date :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          child: (snapshot
                                                                      .data![i]
                                                                      .submittedOn !=
                                                                  null)
                                                              ? Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    DateFormat(
                                                                        'dd-MM-yyyy')
                                                                        .format(
                                                                      DateTime.parse(snapshot
                                                                        .data![i]
                                                                        .submittedOn!)),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                    fontWeight: FontWeight.bold),
                                                                  ),
                                                                )
                                                              : Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    '---',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
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
                                                          20, 10, 10, 1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Establishment type :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (snapshot.data![i]
                                                                  .establishmentId !=
                                                              null)
                                                          ? Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .establishmentType!,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                fontWeight: FontWeight.bold),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                '---',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
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
                                                          20, 10, 10, 1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'District name :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (snapshot.data![i]
                                                                  .establishmentId !=
                                                              null)
                                                          ? Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .district!
                                                                    .districtName!,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,fontWeight: FontWeight.bold),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                '---',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
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
                                                          20, 10, 10, 1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Survey No :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (snapshot.data![i]
                                                                  .establishmentId !=
                                                              null)
                                                          ? Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .surveyNo!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                fontWeight: FontWeight.bold),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                '---',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
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
                                                          20, 10, 10,1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Industry status :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (snapshot.data![i]
                                                                  .establishmentId !=
                                                              null)
                                                          ? Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .industryStatus! !="0" ?
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .industryStatus!:"--",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                    Colors.blue.shade900,
                                                                fontWeight: FontWeight.bold),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                'Invalid data',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
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
                                                          20, 10, 10, 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Village name :',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (snapshot.data![i]
                                                                  .establishmentId !=
                                                              null)
                                                          ? Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .establishmentId!
                                                                    .village!
                                                                    .villageName!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,fontWeight: FontWeight.bold),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              flex: 6,
                                                              child: Text(
                                                                'Invalid data',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ])),
                                        )));
                              }),
                        )),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ))),
    );
  }


  // ignore: missing_return
  Future<List<ApplicationDetailsDto>?> fetchSubmittedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    domain = prefs.getString('domain');
    int? userId = prefs.getInt('userId');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await API.submittedApplications(headers, userId.toString());

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((module) => new ApplicationDetailsDto.fromJson(module))
            .toList();
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  void fetchPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt("userId");
    seatId = pref.getInt("seatId");
    userName = pref.getString("userName");
    email = pref.getString("email");
    mobile = pref.getString("mobile");
    setState(() {
      loading = false;
    });
  }
}

class LineDrawerList extends StatelessWidget {
  const LineDrawerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 580,
      width: MediaQuery.of(context).size.width,
    );
  }
}

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  String? drawerListTile;
  IconData drawerListIcon;

  DrawerList(this.drawerListTile, this.drawerListIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 17,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              drawerListIcon,
              size: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 50,
            ),
            Text(
              drawerListTile!,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
