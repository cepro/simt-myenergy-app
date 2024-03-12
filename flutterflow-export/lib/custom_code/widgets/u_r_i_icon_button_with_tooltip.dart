// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class URIIconButtonWithTooltip extends StatefulWidget {
  const URIIconButtonWithTooltip({
    super.key,
    this.width,
    this.height,
    required this.uri,
    required this.tooltipText,
    required this.icon,
  });

  final double? width;
  final double? height;
  final String uri;
  final String tooltipText;
  final Icon icon;

  @override
  State<URIIconButtonWithTooltip> createState() =>
      _URIIconButtonWithTooltipState();
}

class _URIIconButtonWithTooltipState extends State<URIIconButtonWithTooltip> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: IconButton(
            icon: widget.icon,
            iconSize: 32.0,
            padding: EdgeInsets.zero,
            tooltip: widget.tooltipText,
            onPressed: () {
              launchURL(widget.uri);
            }));
//    return IconButton(
    //      icon: widget.icon,
    //    iconSize: 24.0, // Adjust the size as needed
    //  padding: EdgeInsets.zero,
    //tooltip: widget.tooltipText,
//        onPressed: () async {
    //        launchURL(widget.uri);
    //    });
  }
}
