import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:therapize/components/platform_widgets/platform_tab_scaffold.dart';
import 'package:therapize/pages/homepage.dart';

class HomePageRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      navItems: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text(
            "Home",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text(
            "Messages",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          title: Text(
            "Settings",
          ),
        ),
      ],
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return Container(
              color: Colors.blue,
            );
          case 2:
            return Container(
              color: Colors.orange,
            );
          default:
            return Container();
        }
      },
    );
  }
}
