import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/models/therapist.dart';

class OtherTherapistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: "Search Therapists",
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('therapists').getDocuments(),
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
                  DocumentSnapshot documentSnapshot = documents[i];
                  Therapist therapist = Therapist(
                      name: documentSnapshot.data['name'],
                      rating: documentSnapshot.data['rating'].toDouble(),
                      type: documentSnapshot.data['type'],
                      path: documentSnapshot.reference.path,
                      header: documentSnapshot.data['header'],
                      description: documentSnapshot.data['description'],
                      imagePath: documentSnapshot.data['imagePath'],
                      rate: documentSnapshot.data['rate'].toDouble(),
                      available: documentSnapshot.data['available']);

                  return TherapistCard(
                    therapist: therapist,
                  );
                });
          }
        },
      ),
    );
  }
}
