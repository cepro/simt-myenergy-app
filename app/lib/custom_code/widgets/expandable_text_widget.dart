// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:expandable_text/expandable_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget({
    super.key,
    this.width,
    this.height,
    required this.longText,
  });

  final double? width;
  final double? height;
  final String longText;

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      widget.longText,
      expandText: 'show more',
      collapseText: 'show less',
      maxLines: 1,
      linkColor: Colors.blue,
    );
  }
}
