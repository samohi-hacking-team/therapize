import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';
import 'package:therapize/global/colors.dart';

class PlatformTabScaffold extends StatefulWidget {
  final Widget Function(BuildContext, int) tabBuilder;
  final List<BottomNavigationBarItem> navItems;

  PlatformTabScaffold({@required this.tabBuilder, @required this.navItems});
  @override
  _PlatformTabScaffoldState createState() => _PlatformTabScaffoldState();
}

class _PlatformTabScaffoldState extends State<PlatformTabScaffold> {
  int index;

  @override
  void initState() {
    super.initState();
    index = 0;

  }
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iOS: CupertinoTabScaffold(
        tabBuilder: widget.tabBuilder,
        tabBar: CupertinoTabBar(
          items: widget.navItems,
        ),
      ),
      android: Scaffold(
        body: widget.tabBuilder(context, this.index),
        bottomNavigationBar: BottomNavigationBar(
          items: widget.navItems,
          onTap: (index){
            setState(() {
              this.index = index;
            });
          },
        ),
      ),
    );
  }
}