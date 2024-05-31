import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/loginPage.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Submitted_App.dart';
import 'establishment_list.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  // Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? draftcount;
  void getDraftApplicationsCount() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userId');
    Map<String, String> headers = {
      "Content-Type": "application/json",
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    };
    try {
      final response = await API.getDraftApplicationsCount(headers, userId.toString());
      if (response.statusCode == 200) {
        draftcount = loadDraftApplicationsCount(response.body);
        print('draftcount: $draftcount}');
        setState(() {});
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  dynamic loadDraftApplicationsCount(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  int? subcount;
  void getSubApplicationsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userId');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await API.getSubmittedApplicationsCount(headers, userId.toString());
      if (response.statusCode == 200) {
        subcount = loadSubApplicationsCount(response.body);
        print('subcount: $subcount}');
        setState(() {});
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  dynamic loadSubApplicationsCount(String jsonString) {
    final parsed1 = json.decode(jsonString);
    return parsed1;
  }

  int? approvecount;
  void getApproveApplicationsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userId');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await API.getApprovedApplicationsCount(headers, userId.toString());
      if (response.statusCode == 200) {
        approvecount = loadApproveApplicationsCount(response.body);
        print('approvecount: $approvecount}');
        setState(() {});
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  dynamic loadApproveApplicationsCount(String jsonString) {
    final parsed2 = json.decode(jsonString);
    return parsed2;
  }

  int? establishmentcount;
  void getEstablishmentCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await API.getEstablishmentCount(headers, userId);
      if (response.statusCode == 200) {
        establishmentcount = loadEstablishmentCount(response.body);
        print('establishmentcount: $establishmentcount}');
        setState(() {});
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  dynamic loadEstablishmentCount(String jsonString) {
    final parsed3 = json.decode(jsonString);
    return parsed3;
  }

  @override
  void initState() {
    getDraftApplicationsCount();
    getSubApplicationsCount();
    getApproveApplicationsCount();
    getEstablishmentCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text('Home Screen',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'kanit regular',
                    fontSize: 21.0)),
          ),
          drawer: Drawer(
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
                      width: 9,
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
                InkWell(
                  child: DrawerList(
                    "Logout",
                    Icons.transit_enterexit,
                  ),
                  onTap: _logout,
                ),
                LineDrawerList(),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  new Container(
                    child: new Container(
                      child: Card(
                          margin: EdgeInsets.only(
                              left: 1, top: 0, right: 1, bottom: 1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color(0x802196F3))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Application Status',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]),
                            ),
                          )),
                      height: MediaQuery.of(context).size.height * 0.58,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 40),
                    color: Colors.transparent,
                    child: Column(children: <Widget>[
                      _buildTile(
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Drafted Applications',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Material(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(draftcount.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34.0)),
                                      )))
                                ]),
                          ), onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubmittedApplication()),
                        );
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      _buildTile(
                        Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Material(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(subcount.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 34.0)),
                                        )))
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 4.0)),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _buildTile(
                        Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Approved Applications',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Material(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(approvecount.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 34.0)),
                                        )))
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 4.0)),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0x802196F3))),
                        child: _buildTile(
                          Padding(
                              padding: const EdgeInsets.all(24.0),
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
                                                  color: Colors.amber,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Material(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                                establishmentcount.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 34.0,
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
                      SizedBox(
                        height: 60,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          )),
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
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
            ],
          ),
        );
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

  _logout() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            content: new Text('Do you really want to logout?'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "CANCEL",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              // ignore: deprecated_member_use
              new ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
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
}
