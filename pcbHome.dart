import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/inspection_list.dart';
import 'package:pcbapp/Activity/loginPage.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? inspListCount;
  bool loading = true;
  String? userId, seatUserAllottedId;

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF002D68),
          title: Text('Home', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _onBackPressed,
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Application Status',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900]),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      width: 60.0,
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.blue,
                                      ))),
                            ),
                            _buildTile(
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Inspections',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Material(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: loading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.blue[900],
                                                      strokeWidth: 2.0,
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.blue[400]!),
                                                    ),
                                                  )
                                                : Text(
                                                    inspListCount == null
                                                        ? "8"
                                                        : inspListCount
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                          )))
                                    ]),
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => InspectionList(
                                          allotId: seatUserAllottedId))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            /*_buildTile(
                                Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Submitted Applications',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Material(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                child: Center(
                                                    child: Padding(
                                                  padding:
                                                      EdgeInsets.all(10.0),
                                                  child: loading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.blue[
                                                                    900],
                                                            strokeWidth: 2.0,
                                                            valueColor:
                                                                new AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors.blue[
                                                                        400]),
                                                          ),
                                                        )
                                                      : Text(
                                                          subCount.toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                )))
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.0)),
                                      ],
                                    )),
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            SubmittedApplication(userId: userId))),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              _buildTile(
                                Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Approved Applications',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Material(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                child: Center(
                                                    child: Padding(
                                                  padding:
                                                      EdgeInsets.all(10.0),
                                                  child: loading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.blue[
                                                                    900],
                                                            strokeWidth: 2.0,
                                                            valueColor:
                                                                new AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors.blue[
                                                                        400]),
                                                          ),
                                                        )
                                                      : Text(
                                                          appCount.toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                )))
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.0)),
                                      ],
                                    )),
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => InspectionList())),
                              ),*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          _onBackPressed();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              gradient: LinearGradient(colors: [/*Colors.blue, Color(0xFF002D68)*/Colors.blue.shade900,Colors.blue.shade900]),),
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      /*Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color(0x802196F3))),
                          child: _buildTile(
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Establishments',
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Material(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: loading
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.blue[900],
                                                        strokeWidth: 2.0,
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .blue[400]),
                                                      ),
                                                    )
                                                  : Text(estCount.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: '')),
                                            )))
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 4.0)),
                                  ],
                                )),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => EstablishmentList())),
                          ),
                        ),
                        */ /*Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color(0x802196F3))),
                          child: _buildTile(
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Inspections',
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ],
                                        ),
                                        Material(
                                            color: Colors.purple  ,
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: loading
                                                      ? Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                      backgroundColor:
                                                      Colors.blue[900],
                                                      strokeWidth: 2.0,
                                                      valueColor:
                                                      new AlwaysStoppedAnimation<
                                                          Color>(
                                                          Colors
                                                              .blue[400]),
                                                    ),
                                                  )
                                                      : Text('2',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          fontFamily: '')),
                                                )))
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 4.0)),
                                  ],
                                )),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => InspectionList(userId: userId,))),
                          ),
                        ),*/ /*
                        SizedBox(
                          height: 60,
                        ),*/
                    ]),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            content: new Text('Do you really want to exit?'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "CANCEL",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              // ignore: deprecated_member_use
              new TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text(
                  "YES",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  fetchInspListCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userId');
    try {
      var response = await API.getInspectedApplicationCount({
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, userId);

      if (response.statusCode == 200) {
        inspListCount = loadEstCount(response.body);
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        print("Error.");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error.");
    }
  }

  static loadDraftCount(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  static loadSubCount(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  static loadAppCount(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  static loadEstCount(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  fetchCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId').toString();
    // seatUserAllottedId = prefs.getInt('seatUserAllottedId').toString();
    fetchInspListCount();
  }
}
