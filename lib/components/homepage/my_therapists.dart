import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:therapize/components/platform_widgets/platform_page_route.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/my_therapist_page.dart';
import 'package:therapize/pages/other_therapists_page.dart';

import '../../models/therapist.dart';
import '../../models/therapist.dart';

class MyTherapists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
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
                      onTap: () => Navigator.of(context)
                          .push(platformPageRoute(MyTherapistsPage())),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      rating: documentSnapshot.data['rating']
                                          .toDouble(),
                                      type: documentSnapshot.data['type'],
                                      path: documentSnapshot.data['path'],
                                      description:
                                          documentSnapshot.data['description'],
                                      imagePath:
                                          documentSnapshot.data['imagePath'],
                                      price: documentSnapshot.data['price']);

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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ThemedText(
                      "Other Therapists",
                      textType: TextType.header,
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .push(platformPageRoute(OtherTherapistsPage())),
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

                    return Container(
                      height: 130,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (c, i) {
                            DocumentSnapshot document = documents[i];
                            Therapist therapist = new Therapist(
                                description: document['description'],
                                name: document['name'],
                                imagePath: document['imagePath'],
                                path: document['path'],
                                price: document['price'],
                                rating: document['rating'].toDouble(),
                                type: document['type']);

                            return TherapistCard(
                              therapist: therapist,
                            );
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
