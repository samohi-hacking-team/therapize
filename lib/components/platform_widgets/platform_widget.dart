import 'dart:io';

import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  final Widget iOS;
  final Widget android;

  PlatformWidget({
    this.iOS,
    this.android,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Platform.isIOS && this.iOS != null) {
      return this.iOS;
    }else if(this.android != null) {
      return this.android;
    }else{
      return Container();
    }
  }
}
