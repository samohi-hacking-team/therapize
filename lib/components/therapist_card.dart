import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/global/colors.dart';
import 'package:therapize/models/therapist.dart';
import 'package:therapize/pages/therapist_page.dart';

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({
    this.therapist,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: FlatButton(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                          child: drawImage(therapist.imagePath, context),
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
          ),
          this.therapist.available ? Positioned(
            bottom: 22,
            right: 22,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 5,
                width: 5,
                color: Colors.greenAccent,
              ),
            )
          ):Container(),
        ],
      );
    } catch (e) {
      return Container();
    }
  }
}

FutureBuilder drawImage(String imageName, BuildContext context) {
  return FutureBuilder(
    future: FirebaseStorage.instance.ref().child(imageName).getDownloadURL(),
    builder: (
      c,
      s,
    ) {
      if (s.connectionState != ConnectionState.done) {
        return Container(
          color: AppTheme.baseColor,
        );
      } else if (s.hasError) {
        print("EOROROROROROROROROROROR");
        print(s.error);
        return Container(
          color: AppTheme.baseColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ThemedText(
                "Sorry, we can't fetch this image right now.",
              )
            ],
          ),
        );
      } else {
        String downloadLink = s.data;
        return Image.network(
          downloadLink,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Column(children: <Widget>[
              Container(
                color: AppTheme.baseColor,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ]);
          },
        );
      }
    },
  );
}
