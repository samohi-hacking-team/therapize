import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/platform_widgets/platform_text_field.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/global/colors.dart';
import 'package:therapize/models/therapist.dart';

class SearchTherapistsPage extends StatefulWidget {
  @override
  _SearchTherapistsPageState createState() => _SearchTherapistsPageState();
}

class _SearchTherapistsPageState extends State<SearchTherapistsPage> {
  String searching;

  @override
  void initState() {
    super.initState();
    searching = "";
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: 'Search Therapists',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (Platform.isIOS) Container(height: 90),
            Material(
              type: MaterialType.transparency,
              child: TextField(
                style: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white),
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  labelStyle: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.grey[900]
                        : Colors.grey[300],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.baseColor,
                    ),
                  ),
                ),
                onChanged: (v) {
                  setState(() {
                    searching = v;
                  });
                },
              ),
            ),
            FutureBuilder(
              future:
                  Firestore.instance.collection('therapists').getDocuments(),
              builder: (c, s) {
                if (s.connectionState != ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Divider(),
                      Text(
                        "Loading",
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                } else {
                  QuerySnapshot snapshot = s.data;
                  List documents = snapshot.documents;

                  return Search(
                    documents: documents,
                    searchString: this.searching,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key key, @required this.documents, this.searchString})
      : super(key: key);

  final List documents;
  final String searchString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 30),
          scrollDirection: Axis.vertical,
          itemCount: documents.length,
          itemBuilder: (c, i) {
            DocumentSnapshot document = documents[i];
            Therapist therapist = new Therapist(
                header: document['header'],
                description: document['description'],
                name: document['name'],
                imagePath: document['imagePath'],
                path: document.reference.path,
                rate: document['rate'].toDouble(),
                rating: document['rating'].toDouble(),
                type: document['type']);

            return therapist.name
                        .toLowerCase()
                        .contains(this.searchString.toLowerCase()) ||
                    therapist.type
                        .toLowerCase()
                        .contains(this.searchString.toLowerCase())
                ? TherapistCard(
                    therapist: therapist,
                  )
                : Container();
          }),
    );
  }
}
