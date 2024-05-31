import 'package:flutter/material.dart';

class Pcb extends StatefulWidget {
  @override
  _PcbState createState() => _PcbState();
}

class _PcbState extends State<Pcb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("File a complaint againt PCB",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'kanit regular',
                letterSpacing: 0,
              )),
          leading: Icon(
            Icons.menu,
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
            ],
          ),
          SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0),
                  child: Column(children: <Widget>[
                    Container(
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        TextFieldHeading("Petitioners name:"),
                        TextField2(
                            "Name", "Enter your name", 1, TextInputType.text),
                        SizedBox(height: 40),
                        TextFieldHeading("Address:"),
                        TextField1("Enter your address", "Wont exceed 4 lines",
                            4, TextInputType.text),
                        SizedBox(height: 40),
                        TextFieldHeading("Detailed description:"),
                        TextField1("Detailed description",
                            "Enter in detailed manner", 4, TextInputType.text),
                        SizedBox(height: 40),
                        Text('Email:',
                            style: TextStyle(
                              fontFamily: 'kanit regular',
                              letterSpacing: .6,
                            )),
                        TextField1("enter your email", "Example@gmail.com", 1,
                            TextInputType.emailAddress),
                        SizedBox(height: 40),
                        TextFieldHeading("Phone number"),
                        TextField1("Enter your phone number",
                            "Maximum 10 digits", 1, TextInputType.number),
                        SizedBox(height: 40),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Choose file',
                                style: TextStyle(
                                  fontFamily: 'kanit regular',
                                  letterSpacing: .6,
                                ))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(Icons.camera), onPressed: () {})
                          ],
                        ),
                        // ignore: deprecated_member_use
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Submit'),
                          // textColor: Colors.white,
                          // color: Colors.blueAccent,
                        )
                      ]),
                    )
                  ])))
        ]));
  }
}

// ignore: must_be_immutable
class TextFieldHeading extends StatelessWidget {
  String? name;
  TextFieldHeading(this.name);

  @override
  Widget build(BuildContext context) {
    return Text(name!,
        style: TextStyle(
          fontFamily: 'kanit regular',
          letterSpacing: .6,
        ));
  }
}

// ignore: must_be_immutable
class TextField2 extends StatefulWidget {
  String? label2;
  String? hint2;
  int lines2;
  TextInputType keyboard2;

  TextField2(this.label2, this.hint2, this.lines2, this.keyboard2);

  @override
  _TextField2State createState() => _TextField2State();
}

class _TextField2State extends State<TextField2> {
  TextEditingController? controller;

  bool isNameValid = true;

  RegExp regExp = new RegExp(
    r'^[a-zA-Z]+$',
  );

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: new ThemeData(
          primaryColor: Colors.blueGrey,
          primaryColorDark: Colors.black,
          // ignore: deprecated_member_use
          // cursorColor: Colors.black87,
        ),
        child: TextField(
          onChanged: (value) {
            if (regExp.hasMatch(value)) {
              isNameValid = true;
            } else {
              isNameValid = false;
            }
            setState(() {});
          },
          maxLines: widget.lines2,
          decoration: InputDecoration(
              labelText: widget.label2,
              border: OutlineInputBorder(),
              hintText: widget.hint2,
              errorText: isNameValid ? null : "Invalid name"),
          controller: controller,
          keyboardType: widget.keyboard2,
        ));
  }
}

// ignore: must_be_immutable
class TextField1 extends StatefulWidget {
  String? label;
  String? hint;
  int lines;
  TextInputType keyboard;

  TextField1(this.label, this.hint, this.lines, this.keyboard);

  @override
  _TextField1State createState() => _TextField1State();
}

class _TextField1State extends State<TextField1> {
  @override
  Widget build(BuildContext context) {
    bool _validate = false;

    final _text = TextEditingController();
    return Theme(
        data: new ThemeData(
          primaryColor: Colors.blueGrey,
          primaryColorDark: Colors.black,
          // ignore: deprecated_member_use
          // cursorColor: Colors.black87,
        ),
        child: TextField(
          controller: _text,
          maxLines: widget.lines,
          decoration: InputDecoration(
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
            labelText: widget.label,
            border: OutlineInputBorder(),
            hintText: widget.hint,
          ),
          keyboardType: widget.keyboard,
        ));
  }
}
