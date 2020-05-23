import 'platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformSliverAppBar extends PlatformWidget {
  final String title;

  PlatformSliverAppBar({
    Key key,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iOS: CupertinoSliverNavigationBar(
        largeTitle: Text(
          this.title,
        ),
      ),
      android: SliverAppBar(
        title: Text(
          this.title,
        ),
      ),
    );
  }
}
