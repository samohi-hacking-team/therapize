import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/therapist_page.dart';

import '../../models/therapist.dart';
import '../../models/therapist.dart';

class MyTherapists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThemedText(
                  "My Therapists",
                  textType: TextType.header,
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ThemedText(
                      "See all",
                      textType: TextType.selectable,
                    ),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection('users')
                .document('test')
                .collection('myTherapists')
                .getDocuments(),
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
                print(s.error);
                print(s.hasError);
                print('~~~~~~~~~~~~~~~~');
                QuerySnapshot snapshot = s.data;
                List documents = snapshot.documents;

                return Container(
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: documents.length,
                      itemBuilder: (c, i) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: Firestore.instance
                              .collection('therapists')
                              .document(documents[i].documentID)
                              .get(),
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
                              DocumentSnapshot documentSnapshot = s.data;

                              Therapist therapist = new Therapist(
                                  name: documentSnapshot.data['name'],
                                  rating: documentSnapshot.data['rating'].toDouble(),
                                  type: documentSnapshot.data['type'],
                                  path: documentSnapshot.data['path'],
                                  description:
                                      documentSnapshot.data['description']);

                              return TherapistCard(
                                therapist: therapist,
                              );
                            }
                          },
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({
    this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.grey[100]
            : Colors.grey[900],
        padding: EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 80,
                    color: Colors.white,
                    width: 80,
                    child: FlutterLogo(),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThemedText(
                      this.therapist.name,
                      textType: TextType.header,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                    ThemedText(
                      this.therapist.type,
                      textType: TextType.subtitle,
                      textStyle: TextStyle(
                        //fontSize: 17,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                    ),
                    Container(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: CupertinoColors.systemYellow,
                        ),
                        ThemedText(
                          this.therapist.rating.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            Platform.isIOS
                ? CupertinoPageRoute(
                    builder: (c) => TherapistPage(
                          this.therapist,
                        ))
                : MaterialPageRoute(
                    builder: (c) => TherapistPage(this.therapist)),
          );
        },
      ),
    );
  }
}
