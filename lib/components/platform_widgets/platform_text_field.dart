import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapize/components/platform_widgets/platform_widget.dart';

class PlatformTextField extends PlatformWidget {
  final Function onChanged;
  final String labelText;
  final String hintText;

  PlatformTextField({
    this.onChanged,
    this.labelText,
    this.hintText,
  }) : super(
          iOS: Material(
            type: MaterialType.transparency,
                      child: TextField(
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
              ),
              onChanged: onChanged,
            ),
          ),
          android: TextField(
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
            ),
            onChanged: onChanged,
          ),
        );
}
