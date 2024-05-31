import 'package:flutter/material.dart';
import 'package:pcbapp/Utility/strings.dart';

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(Strings.listOfComplaints,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'kanit regular',
                letterSpacing: 0,
              )),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Received'),
              Tab(text: 'Assigned'),
              Tab(text: 'Completed')
            ],
          ),
        ),
        body: TabBarView(children: [
          Screen1(),
          Screen2(),
          Screen3(),
        ]),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Received'),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Assigned'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Completed'),
      ),
    );
  }
}
