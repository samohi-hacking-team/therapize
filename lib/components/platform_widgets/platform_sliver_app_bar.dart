import 'platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformSliverAppBar extends PlatformWidget {
  final String title;

  PlatformSliverAppBar({
    Key key,
    @required this.title,
  }) : super(
          iOS: CupertinoSliverNavigationBar(
            largeTitle: Text(
              title,
            ),
          ),
          android: SliverAppBar(
            title: Text(
              title,
            ),
          ),
        );
}
