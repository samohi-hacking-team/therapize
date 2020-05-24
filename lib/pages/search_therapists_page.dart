import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';

class SearchTherapistsPage extends StatefulWidget {
  @override
  _SearchTherapistsPageState createState() => _SearchTherapistsPageState();
}

class _SearchTherapistsPageState extends State<SearchTherapistsPage> {
  String output;

  @override
  void initState() {
    super.initState();
    output = "";
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
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    output = v;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
