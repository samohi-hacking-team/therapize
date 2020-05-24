import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/therapist_page.dart';

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
                    child: drawImage(therapist.imagePath, context, 80, 80),
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
                    ),
                  )
                : MaterialPageRoute(
                    builder: (c) => TherapistPage(
                      this.therapist,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

FutureBuilder drawImage(
    String imageName, BuildContext context, double height, double width) {
  return FutureBuilder(
    future: FirebaseStorage .instance
        .ref()
        .child(imageName)
        .getDownloadURL(),
    builder: (
      c,
      s,
    ) {
      if (s.connectionState != ConnectionState.done) {
        return Container(
          color: Color(0xFFf8c630).withOpacity(.25),
          height: height,
        );
      } else if (s.hasError) {
        return Container(
          color: Color(0xFFf8c630).withOpacity(.25),
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Icon(Mdi.alertCircleOutline),
              Text("Sorry, we can't fetch this image right now.",
                  textAlign: TextAlign.center)
            ],
          ),
        );
      } else {
        String downloadLink = s.data;
        return Image.network(
          downloadLink,
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Column(children: <Widget>[
              Container(
                color: Color(0xFFf8c630).withOpacity(.25),
                height: height,
              ),
              LinearProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              )
            ]);
          },
        );
      }
    },
  );
}