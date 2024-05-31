import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pcbapp/Animation/Complaint_Alert.dart';
import 'package:pcbapp/ServiceVO/ComplaintsDto.dart';
import 'package:email_validator/email_validator.dart';
import 'loginPage.dart';

import '../Now/fileapi.dart';

class FileComplaint extends StatefulWidget {
  @override
  _FileComplaintState createState() => _FileComplaintState();
}

class _FileComplaintState extends State<FileComplaint> {
  bool press = true;
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF002D68),
            title: Text("File a complaint",style: TextStyle(color: Colors.white,fontSize: 20),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _onBackPressed,
            ),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('File Complaint Against:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              letterSpacing: .6,
                            )),
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
                                    style: !press ? ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            10),
                                        side: BorderSide(
                                          color: Color(0xFF0063cc), // Border color
                                          width: 2, // Border width
                                        ),//
                                      ),
                                    ) : ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                      Color(0xFF0063cc),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            10),
                                        side: BorderSide(
                                          color: Color(0xFF0063cc), // Border color
                                          width: 2, // Border width
                                        ),//
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        press =true;
                                        _hasBeenPressed1 = !_hasBeenPressed1;
                                        _hasBeenPressed2 = !_hasBeenPressed2;
                                      });
                                      // PcbLogin();

                                      PcbForm();
                                    },
                                    child: ListTile(
                                      title: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3, bottom: 3),
                                          child: Text(
                                            'PCB',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: !press
                                                  ? Color(0xFF0063cc)
                                                  : Colors.white,
                                            ),
                                          ),
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
                                      style: !press ? ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                        Color(0xFF0063cc),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          side: BorderSide(
                                            color: Color(0xFF0063cc), // Border color
                                            width: 2, // Border width
                                          ),//
                                        ),
                                      ) : ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          side: BorderSide(
                                            color: Color(0xFF0063cc), // Border color
                                            width: 2, // Border width
                                          ),//
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          press = false;
                                          _hasBeenPressed1 = !_hasBeenPressed1;
                                          _hasBeenPressed2 = !_hasBeenPressed2;
                                        });

                                        IndustryForm();
                                        // IndustryLogin();
                                      },
                                      child: ListTile(
                                        title: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, bottom: 3),
                                            child: Text(
                                              'INDUSTRY',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: !press
                                                      ? Colors.white :
                                                  Color(0xFF0063cc)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           height: 50,
                        //           width: MediaQuery.of(context).size.width,
                        //           //  padding: EdgeInsets.symmetric(vertical: 12),
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //               borderRadius:
                        //                   BorderRadius.all(Radius.circular(5))),
                        //           // ignore: deprecated_member_use
                        //           child: ElevatedButton(
                        //             /*shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(8.0),
                        //                 side: BorderSide(color: Colors.blue)),
                        //             color: !press ? Colors.white : Color(0xFF002D68),*/
                        //             onPressed: () {
                        //               setState(() {
                        //                 press = false;
                        //                 _hasBeenPressed1 = !_hasBeenPressed1;
                        //                 _hasBeenPressed2 = !_hasBeenPressed2;
                        //               });
                        //             },
                        //             child: ListTile(
                        //               title: Container(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.fromLTRB(
                        //                       8, 3, 8, 7),
                        //                   child: Text(
                        //                     'PCB ',
                        //                     textAlign: TextAlign.center,
                        //                     style: TextStyle(
                        //                       fontSize: 18,
                        //                       //fontWeight: FontWeight.bold,
                        //                       color: !press
                        //                           ? Color(0xFF002D68)
                        //                           : Colors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: 20),
                        //       Expanded(
                        //         child: Container(
                        //           height: 50,
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Container(
                        //             // ignore: deprecated_member_use
                        //             child: ElevatedButton(
                        //               /*shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(8.0),
                        //                   side: BorderSide(
                        //                       color: Colors.blue)),
                        //               color: !press
                        //                   ? Color(0xFF002D68)
                        //                   : Colors.white,*/
                        //               onPressed: () {
                        //                 setState(() {
                        //                   press = false;
                        //                   _hasBeenPressed1 = !_hasBeenPressed1;
                        //                   _hasBeenPressed2 = !_hasBeenPressed2;
                        //                 });
                        //               },
                        //               child: ListTile(
                        //                 title: Container(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.fromLTRB(
                        //                         0, 2, 0, 8),
                        //                     child: Text(
                        //                       'INDUSTRY ',
                        //                       textAlign: TextAlign.center,
                        //                       style: TextStyle(
                        //                         fontSize: 18,
                        //                         //fontWeight: FontWeight.bold,
                        //                         color: !press
                        //                             ? Colors.white
                        //                             : Color(0xFF002D68),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ]),
                        press ? PcbForm() : IndustryForm()
                      ])))),
    );
  }
  Future<bool> _onBackPressed() async{
   return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class PcbForm extends StatefulWidget {
  const PcbForm({
    Key? key,
  }) : super(key: key);

  @override
  _PcbFormState createState() => _PcbFormState();
}

class _PcbFormState extends State<PcbForm> {
  TextEditingController petitionernamecont1 = TextEditingController();
  TextEditingController addresscont1 = TextEditingController();
  TextEditingController ddcont1 = TextEditingController();
  TextEditingController emailcont1 = TextEditingController();
  TextEditingController numbercont1 = TextEditingController();
  TextEditingController indnamecont1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(height: 40),
        TextFormField(
          validator: (value) {
            Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
            RegExp regex = new RegExp(pattern.toString());
            if (!regex.hasMatch(value!))
              return 'Invalid Name';
            else
              return null;
          },
          controller: petitionernamecont1,
          decoration: _entryField('Petitioner\'s Name'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) =>
              EmailValidator.validate(value!) ? null : "Invalid email address",
          keyboardType: TextInputType.emailAddress,
          controller: emailcont1,
          decoration: _entryField('Email Address'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Address cant be empty';
            }
            return null;
          },
          controller: addresscont1,
          maxLines: 3,
          decoration: _entryField('Address'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Mobile number cant be empty';
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          controller: numbercont1,
          decoration: _entryField('Mobile No'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Description cant be empty';
            }
            return null;
          },
          controller: ddcont1,
          maxLines: 4,
          decoration: _entryField('Issue Description'),
        ),
        SizedBox(height: 20),
        Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _submitButton(context),
        ]))
      ]),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            ComplaintsDto filetemp1 = new ComplaintsDto();

            filetemp1.petitionerName = petitionernamecont1.text;
            filetemp1.address = addresscont1.text;
            filetemp1.industryName = indnamecont1.text;
            filetemp1.description = ddcont1.text;
            filetemp1.email = emailcont1.text;
            filetemp1.mobileNo = numbercont1.text;
            // if (filetemp1.district == null) {
            //   filetemp1.district = new DistrictSetup();
            //   filetemp1.district.id = _value;
            // }
            filetemp1.acknowledgeStatus = "P";
            filetemp1.against = "Pcb";

            ComplaintsDto user1 = await fileApi(filetemp1);
            if (user1 != null) {
              showAlertDialog(context, user1);
            } else {
              Fluttertoast.showToast(
                  msg: "Something went wrong",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
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
                    color: Colors.grey.shade400,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient:
                  LinearGradient(colors: [Colors.blue.shade900,Colors.blue.shade900/*Colors.blue, *//*Color(0xFF002D68),Color(0xFF002D68)*/])),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 17, color: Colors.white)),
        ));
  }
}

_entryField(String? title) {
  return InputDecoration(
      labelText: title,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)));
}

class IndustryForm extends StatefulWidget {
  const IndustryForm({
    Key? key,
  }) : super(key: key);

  @override
  _IndustryFormState createState() => _IndustryFormState();
}

class _IndustryFormState extends State<IndustryForm> {
  TextEditingController petitionernamecont = TextEditingController();
  TextEditingController addresscont = TextEditingController();
  TextEditingController ddcont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController numbercont = TextEditingController();
  TextEditingController indnamecont = TextEditingController();
  int _value = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(height: 40),
        TextFormField(
          validator: (value) {
            Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
            RegExp regex = new RegExp(pattern.toString());
            if (!regex.hasMatch(value!))
              return 'Invalid Name';
            else
              return null;
          },
          controller: petitionernamecont,
          decoration: _entryField('Petitioner\'s Name'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) =>
              EmailValidator.validate(value!) ? null : "Invalid email address",
          controller: emailcont,
          keyboardType: TextInputType.emailAddress,
          decoration: _entryField('Email Address'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Address cant be empty';
            }
            return null;
          },
          controller: addresscont,
          maxLines: 3,
          decoration: _entryField('Address'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = new RegExp(pattern.toString());
            if (value!.length == 0) {
              return 'Please enter mobile number';
            } else if (!regExp.hasMatch(value)) {
              return 'Please enter valid mobile number';
            }
            return null;
          },
          controller: numbercont,
          keyboardType: TextInputType.phone,
          decoration: _entryField('Mobile No'),
        ),
        Row(children: [
          SizedBox(width: 10),
          Text(
            'Select District:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 10),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20.0),
              child: DropdownButton(
                  // isExpanded: true,
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Trivandrum"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Kollam"),
                      value: 2,
                    ),
                    DropdownMenuItem(child: Text("Alappuzha"), value: 3),
                    DropdownMenuItem(child: Text("Ernakulam"), value: 4),
                    DropdownMenuItem(child: Text("Idukki"), value: 5),
                    DropdownMenuItem(child: Text("Pathanamthitta"), value: 6),
                    DropdownMenuItem(child: Text("Wayanad"), value: 7),
                    DropdownMenuItem(child: Text("Thrissur"), value: 8),
                    DropdownMenuItem(child: Text("Palakkad"), value: 9),
                    DropdownMenuItem(child: Text("Malappuram"), value: 10),
                    DropdownMenuItem(child: Text("Kozhikode"), value: 11),
                    DropdownMenuItem(child: Text("Kottayam"), value: 12),
                    DropdownMenuItem(child: Text("Kannur"), value: 13),
                    DropdownMenuItem(child: Text("Kasaragod"), value: 14),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                  }))
        ]),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Industry name cant be empty';
            }
            return null;
          },
          controller: indnamecont,
          decoration: _entryField('Industry Name'),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Issue description cant be empty';
            }
            return null;
          },
          controller: ddcont,
          maxLines: 4,
          decoration: _entryField('Issue Description'),
        ),
        SizedBox(height: 20),
        Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _submitButton(context),
        ]))
      ]),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            ComplaintsDto filetemp1 = new ComplaintsDto();

            filetemp1.petitionerName = petitionernamecont.text;
            filetemp1.address = addresscont.text;
            filetemp1.industryName = indnamecont.text;
            filetemp1.description = ddcont.text;
            filetemp1.email = emailcont.text;
            filetemp1.mobileNo = numbercont.text;
            // if (filetemp1.district != null) {
            //   filetemp1.district = new DistrictSetup();
            //   filetemp1.district.id = _value;
            // }
            filetemp1.acknowledgeStatus = "P";
            filetemp1.against = "Industry";

            ComplaintsDto user1 = await fileApi(filetemp1);
            if (user1 != null) {
              showAlertDialog(context, user1);
            } else {
              Fluttertoast.showToast(
                  msg: "Something went wrong",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
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
                  color: Colors.grey.shade400,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(colors: [Colors.blue, Color(0xFF002D68)]),
          ),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 17, color: Colors.white)),
        ));
  }
}

showAlertDialog(BuildContext context, ComplaintsDto user1) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: ComplaintAlertDialog(
            alertTitle: alertTitle(
              "Complaint Registered, Your Complaint Id is:",
            ),
            alertSubtitle: alertSubtitle(
              user1.compId,
            ),
            // alertType: RichAlertType.SUCCESS,
            actions: <Widget>[
              // ignore: deprecated_member_use
              ElevatedButton(
                // style: ButtonStyle(backgroundColor: Colors.green[400]),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ));
    },
  );
}
