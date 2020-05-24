import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/models/therapist.dart';

class MyTherapistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: "My Therapists",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QuerySnapshot>(
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

              return ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  scrollDirection: Axis.vertical,
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
                                    path: documentSnapshot.reference.path,
                            header: documentSnapshot.data['header'],
                            description: documentSnapshot.data['description'],
                            imagePath: documentSnapshot.data['imagePath'],
                            rate: documentSnapshot.data['rate'].toDouble(),
                          );

                          return TherapistCard(
                            therapist: therapist,
                          );
                        }
                      },
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
