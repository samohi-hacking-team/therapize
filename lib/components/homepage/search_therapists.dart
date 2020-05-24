import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_page_route.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/global/colors.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/search_therapists_page.dart';

class SearchTherapists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ThemedText(
                    "Search Therapists",
                    textType: TextType.header,
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      platformPageRoute(
                        SearchTherapistsPage(),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ThemedText(
                        "Search",
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: AppTheme.baseColor,
                        child: Center(
                          child: Platform.isIOS
                              ? CupertinoActivityIndicator()
                              : CircularProgressIndicator(),
                        ),
                        height: 130,
                      ),
                    ),
                  );
                } else {
                  QuerySnapshot snapshot = s.data;
                  List documents = snapshot.documents;

                  return Column(
                    children: List.generate(documents.length, (index) {
                      DocumentSnapshot document = documents[index];
                      Therapist therapist = new Therapist(
                        header: document['header'],
                        description: document['description'],
                        name: document['name'],
                        imagePath: document['imagePath'],
                        path: document['path'],
                        rate: document['rate'].toDouble(),
                        rating: document['rating'].toDouble(),
                        type: document['type'],
                        available: document['available'],
                      );

                      return Container(
                        height: 130,
                        child: TherapistCard(
                          therapist: therapist,
                        ),
                      );
                    }),
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
