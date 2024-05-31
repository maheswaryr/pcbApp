import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/loginPage.dart';
import 'package:pcbapp/ServiceVO/ComplaintsDto.dart';
import 'package:pcbapp/api/api.dart';
import '../TrackSubmitAPI.dart';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class Track extends StatefulWidget {
  Track() : super();

  final String title = "AutoComplete Demo";

  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  String? email;
  AutoCompleteTextField? searchTextField;
  GlobalKey<AutoCompleteTextFieldState<dynamic>> key = new GlobalKey();
  // ignore: deprecated_member_use
  static List<dynamic> compId = [];

  final TextEditingController controller = new TextEditingController();
  bool loading = true;
  void getUsers() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'};
    try {
      var response = await API.searchQueryService(headers);

      if (response.statusCode == 200) {
        compId = loadUsers(response.body);
        print('compId: ${compId.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<dynamic> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString);
    return parsed;
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF002D68),
            title: Text('Track your complaints',style: TextStyle(color: Colors.white,fontSize: 20),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _onBackPressed,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child:
                new Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              SizedBox(
                height: 10,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.blue[900],
                      strokeWidth: 2.0,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
                    ))
                  : searchTextField = AutoCompleteTextField<dynamic>(
                      key: key,
                      clearOnSubmit: false,
                      suggestions: compId,
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
                      controller: controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: Colors.blue[700]!, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: Colors.blueGrey[700]!, width: 1),
                        ),
                        prefixIcon: IconButton(
                          icon: new Icon(
                            Icons.search,
                            color: Colors.blue[700],
                          ),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: new Icon(Icons.cancel),
                          color: Colors.grey,
                          onPressed: () {
                            controller.clear();
                          },
                        ),
                        contentPadding: EdgeInsets.fromLTRB(1.0, 5.0, 10.0, 7.0),
                        hintText: 'Enter your complaint Id',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      itemFilter: (item, query) {
                        return item
                            .toString()
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.toString().compareTo(b.toString());
                      },
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField!.textField!.controller!.text =
                              item.toString();
                        });
                      },
                      itemBuilder: (context, item) {
                        // ui for the autocompelete row
                        return row(item);
                      },
                    ),
              SizedBox(
                height: 14,
              ),
              Container(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _submitButton(controller.text, context),
              ]))
            ]),
          )),
    );
  }

  Widget row(dynamic user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            user,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            width: 10.0,
          ),
          // Text(
          //   user.email,
          // ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

Widget _submitButton(String text, BuildContext context) {
  return InkWell(
    onTap: () async {
      ComplaintsDto tracktemp1 = new ComplaintsDto();

      tracktemp1.compId = text;

      ComplaintsDto user = await trackApi(tracktemp1);
      if (user != null) {
        _settingModalBottomSheet(context, user);
      } else {
        print('error');
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color:Colors.blue.shade900 /*Colors.grey.shade400*/,
                // offset: Offset(2, 4),
                // blurRadius: 5,
                spreadRadius: 2)
          ],),
      child: Text(
        'Search',
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    ),
  );
}

void _settingModalBottomSheet(context, ComplaintsDto user) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          color: Color(0xFFEDF3FC),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: Color(0xFF002D68),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'COMPLAINT DETAILS  -',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'kanit regular',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.compId == null ? "nil" : user.compId!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'kanit regular',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 10.0, right: 30.0, bottom: 30.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Petitioner\'s name :',
                              style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.petitionerName == null ? "nil" : user.petitionerName!,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'kanit regular',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Mobile : ',
                              style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.mobileNo == null ? "nil" : user.mobileNo!,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'kanit regular',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Email : ',
                              style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.email == null ? "nil" : user.email!,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'kanit regular',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address : ',
                              style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.address == null ? "nil" : user.address!,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'kanit regular',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Issue Description : ',
                              style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.description == null ? "nil" : user.description!,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'kanit regular',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Complaint Status : ',
                                style: TextStyle(
                                    fontFamily: 'kanit regular',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Center(child: Builder(builder: (context) {
                              if (user.acknowledgeStatus == 'C') {
                                return Container(
                                  child: Text(
                                    'CLOSED',
                                    style: TextStyle(
                                        color: Colors.red[500],
                                        fontFamily: 'kanit regular',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else if (user.acknowledgeStatus == 'P') {
                                return Container(
                                  child: Text(
                                    'PENDING',
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontFamily: 'kanit regular',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else {
                                return Text(
                                  'OPEN',
                                  style: TextStyle(
                                      color: Colors.green[500],
                                      fontFamily: 'kanit regular',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            }))
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
      );
    },
  );
}
