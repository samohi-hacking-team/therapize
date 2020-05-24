import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/platform_widgets/platform_text_field.dart';

class SearchTherapistsPage extends StatefulWidget {
  @override
  _SearchTherapistsPageState createState() => _SearchTherapistsPageState();
}

class _SearchTherapistsPageState extends State<SearchTherapistsPage> {
  String searching;

  @override
  void initState() {
    super.initState();
    searching = "";
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: 'Search Therapists',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            PlatformTextField(
              onChanged: (v) {
                setState(() {
                  searching = v;
                });
              },
              labelText: 'Search',
              hintText: 'Search Therapists',
            ),
          ],
        ),
      ),
    );
  }
}
