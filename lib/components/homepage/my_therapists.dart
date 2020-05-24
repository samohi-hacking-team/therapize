import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:therapize/components/themed_text.dart';

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
                  therapistName: "Benjamin Swerdlow",
                  rating: '4.2',
                  type: "Existential Therapist",
                  /*
                    Client-Centered Therapist.                    
                    Existential Therapist.
                    Gestalt Therapist.
                    Humanistic Therapist.
                    Interpersonal Therapist.
                    Rational Emotive Behavioral Therapist.
                    Relational Therapist.
                  */
                ),
                TherapistCard(
                  therapistName: "Jessica Golden",
                  rating: '5.0',
                  type: "Humanistic Therapist",
                ),
                TherapistCard(
                  therapistName: "Jason Telanoff",
                  rating: '2.0',
                  type: "Bad Therapist",
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
  final String therapistName;
  final String type;
  final String rating;
  final bool favorite;

  const TherapistCard({
    Key key,
    @required this.therapistName,
    @required this.type,
    @required this.rating,
    this.favorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.grey[100]
            : Colors.grey[900],
        padding: EdgeInsets.all(16),
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
                      this.therapistName,
                      textType: TextType.header,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                    ThemedText(
                      this.type,
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
                          this.rating,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
