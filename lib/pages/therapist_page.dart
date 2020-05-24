import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/global/colors.dart';
import 'package:therapize/models/therapist.dart';

class TherapistPage extends StatefulWidget {
  final Therapist therapist;
  const TherapistPage(this.therapist);

  @override
  _TherapistPageState createState() => _TherapistPageState();
}

class _TherapistPageState extends State<TherapistPage> {
  PanelController controller;
  @override
  void initState() {
    super.initState();
    this.controller = new PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: this.controller,
      minHeight: 80,
      //collapsed: Container(color: ,),
      body: PlatformScaffold(
        appBar: PlatformAppBar(
          title: widget.therapist.name,
        ),
        body: ListView(
          children: [
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<Uint8List>(
                future: FirebaseStorage()
                    .ref()
                    .child(widget.therapist.imagePath)
                    .getData(100000000),
                builder: (c, s) {
                  if (s.connectionState != ConnectionState.done && !s.hasData) {
                    return Container(
                      color: AppTheme.baseColor,
                      child: Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Image.memory(
                      s.data,
                      fit: BoxFit.fitWidth,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: ThemedText(
                widget.therapist.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
