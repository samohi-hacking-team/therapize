import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';
import 'package:therapize/global/colors.dart';

class PlatformScaffold extends PlatformWidget {
  final Widget Function(BuildContext, int) tabBuilder;
  final List<BottomNavigationBarItem> navItems;

  PlatformScaffold({@required this.tabBuilder, @required this.navItems});
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iOS: CupertinoTabScaffold(
        tabBuilder: this.tabBuilder,
         tabBar: CupertinoTabBar(
          items: this.navItems, 
        ),
      ),
      android: (
       
    );
  }
}