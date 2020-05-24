import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PageRoute platformPageRoute(Widget nextPage) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (c) => nextPage,);
  } else {
    return MaterialPageRoute(builder: (c) => nextPage,);
  }
}
