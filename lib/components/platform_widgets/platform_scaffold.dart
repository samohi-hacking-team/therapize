import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:therapize/components/platform_widgets/platform_app_bar.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';

class PlatformScaffold extends PlatformWidget {
  final Widget body;
  final PlatformAppBar appBar;

  PlatformScaffold({@required this.body, this.appBar});
  @override
  Widget build(BuildContext context) {

    print(PlatformAppBar(title: 'smh',).iOS);
    return PlatformWidget(
      iOS: CupertinoPageScaffold(
        child: this.body,
        navigationBar: this.appBar.iOS,
      ),
      android: Scaffold(
        body: this.body,
        appBar: this.appBar.android,
      ),
    );
  }
}
