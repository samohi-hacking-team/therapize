import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';

class PlatformAppBar extends PlatformWidget {
  final String title;
  final Widget action;

  PlatformAppBar({
    @required this.title,
    this.action,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iOS: CupertinoNavigationBar(
        middle: Text(this.title),
        trailing: this.action,
      ),
      android: AppBar(
        title: Text(this.title),
        actions: [this.action ?? Container()],
      ),
    );
  }
}
