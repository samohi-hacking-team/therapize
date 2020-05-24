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
  TextEditingController textEditingController;

  PanelController controller;
  @override
  void initState() {
    super.initState();
    this.controller = new PanelController();
    this.textEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: this.controller,
      parallaxEnabled: true,
      minHeight: 80,
      collapsed: Material(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? CupertinoColors.systemGrey5
            : CupertinoColors.darkBackgroundGray,
        child: InkWell(
          child: Center(
            child: ThemedText(
              "Get Sessions",
              textType: TextType.header,
            ),
          ),
          onTap: () => this.controller.open(),
        ),
      ),
      panel: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: Container(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? CupertinoColors.white
              : CupertinoColors.darkBackgroundGray,
          child: Column(
            children: [
              Container(
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? CupertinoColors.systemGrey5
                    : Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ThemedText(
                      "Get Sessions",
                      textType: TextType.header,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThemedText(
                      "Hourly Rate",
                      textType: TextType.header,
                    ),
                    ThemedText(
                      widget.therapist.rate.toString(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThemedText(
                      "Amount",
                      textType: TextType.header,
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextField(
                          style: TextStyle(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.baseColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      backdropEnabled: true,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ThemedText(
                    widget.therapist.header,
                    textType: TextType.text,
                    textStyle: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ThemedText(
                    widget.therapist.description,
                    textStyle: TextStyle(fontSize: 19),
                  ),
                  Container(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
