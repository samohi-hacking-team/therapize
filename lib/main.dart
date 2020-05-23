import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_app.dart';
import 'package:therapize/global/colors.dart';
import 'package:therapize/pages/homepage_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: "Therapize",
      home: HomePageRouter(),
      materialLightTheme: ThemeData(
        primaryColor: AppTheme.baseColor,
      ),
      materialDarkTheme: ThemeData(
        primaryColor: AppTheme.baseColor,
        brightness: Brightness.dark,
      ),
      cupertinoTheme: CupertinoThemeData(
        primaryColor: AppTheme.baseColor,
      ),
    );
  }
}
