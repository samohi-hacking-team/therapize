import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/therapist_page.dart';

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
          Container(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TherapistCard(
                  therapist: Therapist(
                      name: "Benjamin Swerdlow",
                      rating: 4.2,
                      type: "Existential Therapist",
                      path: "sgsdgsg"),
                ),
                TherapistCard(
                  therapist: Therapist(
                    path: "aasfasf",
                    name: "Jessica Golden",
                    rating: 5.0,
                    type: "Humanistic Therapist",
                  ),
                ),
                TherapistCard(
                  therapist: Therapist(
                    path: "sgsdgdsg",
                    name: "Jason Telanoff",
                    rating: 2.0,
                    type: "Bad Therapist",
                  ),
                )
              ],
            ),
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
                    builder: (c) => TherapistPage(this.therapist,))
                : MaterialPageRoute(
                    builder: (c) => TherapistPage(this.therapist)),
          );
        },
      ),
    );
  }
}
