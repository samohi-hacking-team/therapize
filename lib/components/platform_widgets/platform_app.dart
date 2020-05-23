import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';

class PlatformApp extends PlatformWidget {
  final String title;
  final Widget home;
  final ThemeData materialLightTheme, materialDarkTheme;
  final CupertinoThemeData cupertinoTheme;

  PlatformApp({
    Key key,
    @required this.title,
    @required this.home, 
    @required this.materialLightTheme, 
    @required this.materialDarkTheme, 
    @required this.cupertinoTheme,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      iOS: CupertinoApp(
        title: this.title,
        home: this.home,
        theme: this.cupertinoTheme,
      ),
      android: MaterialApp(
        title: this.title,
        home: this.home,
        theme: this.materialLightTheme,
        darkTheme: this.materialDarkTheme,
      ),
    );
  }
}
