import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:therapize/components/homepage/my_therapists.dart';
import 'package:therapize/components/homepage/search_therapists.dart';
import 'package:therapize/components/platform_widgets/platform_sliver_app_bar.dart';

import '../components/platform_widgets/platform_scaffold.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
          body: CustomScrollView(
        slivers: [
          PlatformSliverAppBar(
            title: "Therapize",
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                MyTherapists(),
                SearchTherapists(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
