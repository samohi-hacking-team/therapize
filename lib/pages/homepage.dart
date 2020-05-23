import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:therapize/components/platform_widgets/platform_scaffold.dart';
import 'package:therapize/components/platform_widgets/platform_sliver_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: CustomScrollView(
        slivers: [
          PlatformSliverAppBar(
            title: "Therapize",
          ),
          
        ],
      ),
    );
  }
}