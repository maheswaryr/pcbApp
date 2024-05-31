import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pcbapp/Activity/industryHome.dart';
import 'package:pcbapp/Animation/Login_Alert.dart';
import 'package:pcbapp/Activity/pcbHome.dart';
import 'package:pcbapp/Activity/trackcomplaint.dart';
import 'package:pcbapp/ServiceVO/LoginRequest.dart';
import 'package:pcbapp/ServiceVO/LoginResponse.dart';
import 'package:pcbapp/ServiceVO/UserBean.dart';
import 'package:pcbapp/api/api.dart';
import 'package:pcbapp/tokenapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'fileComplaint.dart';

/// Created by Vivek on 04/11/20.

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  // ignore: unused_field
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? sessionToken;
  String? domain = "P";
  String? userName;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool press1 = true;
  bool _hasBeenPressed3 = false;
  bool _hasBeenPressed4 = false;
  bool isPassword = true;

  @override
  void initState() {
    super.initState();
    setShare();
  }

  setShare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sessionToken = prefs.getString('token');
    });
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.only(left: 0.0, top: 50.0, right: 0.0, bottom: 30.0),
      child: new Image.asset('assets/logo.png'),
      width: 600.0,
      height: 240.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(),
                      SizedBox(height: 2),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Login as:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: .6,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      //  padding: EdgeInsets.symmetric(vertical: 12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      // ignore: deprecated_member_use
                                      child: ElevatedButton(
                                        style: !press1
                                            ? ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                    color: Color(
                                                        0xFF0063cc), // Border color
                                                    width: 2, // Border width
                                                  ), //
                                                ),
                                              )
                                            : ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xFF0063cc),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                    color: Color(
                                                        0xFF0063cc), // Border color
                                                    width: 2, // Border width
                                                  ), //
                                                ),
                                              ),
                                        onPressed: () {
                                          PcbLogin();
                                        },
                                        child: ListTile(
                                          title: Text(
                                            'PCB USER',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: !press1
                                                  ? Color(0xFF0063cc)
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        // ignore: deprecated_member_use
                                        child: ElevatedButton(
                                          style: !press1
                                              ? ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color(0xFF0063cc),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      color: Color(
                                                          0xFF0063cc), // Border color
                                                      width: 2, // Border width
                                                    ), //
                                                  ),
                                                )
                                              : ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      color: Color(
                                                          0xFF0063cc), // Border color
                                                      width: 2, // Border width
                                                    ), //
                                                  ),
                                                ),
                                          onPressed: () {
                                            IndustryLogin();
                                          },
                                          child: Text(
                                            'INDUSTRY USER',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: !press1
                                                    ? Colors.white
                                                    : Color(0xFF0063cc)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            Column(
                              children: <Widget>[
                                _emailPasswordWidget(),
                                SizedBox(height: 20),
                                _submitButton(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(flex: 5, child: _tcomplaint()),
                                    SizedBox(width: 10),
                                    Expanded(flex: 5, child: _fcomplaint()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginAlertDialog(
          alertTitle: alertTitle("Are you sure?"),
          alertSubtitle: alertSubtitle("Do you really want to exit?"),
          alertType: LoginAlertType.SUCCESS,
          actions: <Widget>[
            // ignore: deprecated_member_use
            new TextButton(
              // color: Colors.green[400],
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "CANCEL",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            // ignore: deprecated_member_use
            new TextButton(
              // color: Colors.red[900],
              onPressed: () => exit(0),
              child: Text(
                "YES",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  PcbLogin() {
    setState(() {
      press1 = true;
      _hasBeenPressed3 = !_hasBeenPressed3;
      _hasBeenPressed4 = !_hasBeenPressed4;
    });
    if (press1) {
      domain = "P";
    }
  }

  // ignore: non_constant_identifier_names
  IndustryLogin() {
    setState(() {
      press1 = false;
      _hasBeenPressed3 = !_hasBeenPressed3;
      _hasBeenPressed4 = !_hasBeenPressed4;
    });
    if (!press1) {
      domain = "I";
    }
  }

  Widget _tcomplaint() {
    return InkWell(
      onTap: () => navigateToTrack(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient:
              LinearGradient(colors: [Color(0xFF0063cc), Color(0xFF0063cc)]),
        ),
        child: Text(
          'Track Complaint ',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }

  Widget _fcomplaint() {
    return InkWell(
      onTap: () => navigateTo(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient:
              LinearGradient(colors: [Color(0xFF0063cc), Color(0xFF0063cc)]),
        ),
        child: Text(
          'File Complaint',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (username.text != '' && password.text != '') {
          LoginRequest tokentemp1 = new LoginRequest();
          tokentemp1.username = username.text;
          tokentemp1.password = password.text;
          tokentemp1.domain = domain;

          LoginResponse response = await tokenApi(tokentemp1);
          if (response.token != null) {
            LoginRequest request = new LoginRequest();
            request.username = username.text;
            request.password = password.text;
            request.domain = domain;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', response.token!);
            String? token = prefs.getString('token');
            String? encodedDate = convert.jsonEncode(request);
            Map<String, String> headers = {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            };
            var res = await API.getUserDetails(encodedDate, headers);
            UserBean? userDetails;
            if (res.statusCode == 200) {
              userDetails = UserBean.fromJson(convert.jsonDecode(res.body));
              if (userDetails != null) {
                prefs.setString('domain', domain!);
                if (userDetails.seatName != null) {
                  prefs.setString('seatName', userDetails.seatName!);
                }
                if (userDetails.firstName != null &&
                    userDetails.lastName != null) {
                  prefs.setString('userName',
                      userDetails.firstName! + userDetails.lastName!);
                }

                if (userDetails.titleName != null) {
                  prefs.setString('titleName', userDetails.titleName!);
                }
                // prefs.setString('firstName', userDetails.firstName!);
                // prefs.setString('email', userDetails.email!);
                // prefs.setString('mobile', userDetails.mobileNo!);
                // prefs.setString('address', userDetails.address!);

                if (userDetails.seatUserAllottedId != null) {
                  prefs.setInt(
                      'seatUserAllottedId', userDetails.seatUserAllottedId!);
                }

                if (userDetails.seatId != null) {
                  prefs.setInt('seatId', userDetails.seatId!);
                }

                if (userDetails.userId != null) {
                  prefs.setInt('userId', userDetails.userId!);
                }

                if (userDetails.officeId != null) {
                  prefs.setInt('officeId', userDetails.officeId!);
                }

                if (domain == "P") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                } else if (domain == "I") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndHome(),
                      ));
                }
              }  else if ((username == '') && (password == '')) {
                _wrongUserPass(
                    "Fields cannot be empty. Please enter username and password");
              } else if (username == '') {
                _wrongUserPass(
                  "Field cannot be empty. Please enter username",
                );
              } else if (password == '') {
                _wrongUserPass("Field cannot be empty. Please enter password");
              }  else if (res.statusCode == 500) {
                _wrongUserPass("Server under maintenance");
              } else if (res.statusCode == 400) {
                _wrongUserPass("Bad Request,\n Retry after 20 mints");
              }
              else {}
            } else {
              Fluttertoast.showToast(
                  msg: "Invalid username/password",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: "Invalid username/password",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blueGrey,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          // return CircularProgressIndicator();
        } else {
          Fluttertoast.showToast(
              msg: "Fields cant be empty",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(colors: [Colors.blue.shade900,Colors.blue.shade900/* Color(0xFF002D68)*/])),
        child: Text(
          'Sign In',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
  Future<void> _wrongUserPass(String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          content: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF01458E)),
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Try Again',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldU("Username", username),
        _entryFieldP(
            "Password", password, Icons.visibility, Icons.visibility_off),
      ],
    );
  }

  Future navigateToTrack() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Track()));
  }

  Future navigateTo() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FileComplaint()));
  }

  Widget _entryFieldU(String title, TextEditingController cn) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: cn,
              decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldP(String title, TextEditingController cn,
      IconData visibility, IconData visibilityOff) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: cn,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: title,
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  isPassword ? Icons.visibility : Icons.visibility_off,
                  color:Colors.blue.shade900 /*Theme.of(context).primaryColorDark*/,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
