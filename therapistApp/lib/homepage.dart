import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'agoraSDK/pages/call.dart';

class EnterID extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          maxLength: "cl6Tn2DILFerddPKOH2k".length,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "ENTER YOUR ID",
            hintText: "cl6Tn2DILFerddPKOH2k",
          ),
          onSubmitted: (v) {
            if (v.length == 20) {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return LoggedIn(
                  id: v,
                );
              }));
            }
          },
        ),
      ),
    );
  }
}

class LoggedIn extends StatefulWidget {
  final String id;

  const LoggedIn({Key key, this.id}) : super(key: key);
  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int checks;
  @override
  void initState() {
    super.initState();
    checks = 0;
    checkForCallsConstantly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Keep your app open or Jason will not love u anymore"),
          Text(
            "Checks " + checks.toString(),
          )
        ],
      ),
    );
  }

  void checkForCallsConstantly() async {
    await Future.delayed(
      Duration(
        seconds: 10,
      ),
    );
    QuerySnapshot snapshots = await Firestore.instance
        .collection("therapists")
        .document(widget.id)
        .collection('requests')
        .getDocuments();
    if (snapshots.documents.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => CallPage(
            channelName: snapshots.documents.first.documentID,
          ),
        ),
      );
    } else {
      setState(() {
        checks = checks+1;
      });
      checkForCallsConstantly();
    }
  }
}
