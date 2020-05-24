import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';

class PlatformAppBar extends PlatformWidget {
  final String title;
  final Widget action;

  PlatformAppBar({
    @required this.title,
    this.action,
  }) : super(
          iOS: CupertinoNavigationBar(
            middle: Text(
              title,
            ),
            trailing: action,
          ),
          android: AppBar(
            title: Text(
              title,
            ),
            actions: [
              action ?? Container(),
            ],
          ),
        );
}
