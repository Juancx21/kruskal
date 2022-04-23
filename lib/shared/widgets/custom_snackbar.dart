import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';

class CustomSnackBar {
  static SnackBar errorSnackBar({String text = "Error", bool dark = false}) {
    return SnackBar(
      content: Text(
        text,
        style: UiFonts.txtbody1(Colors.white),
      ),
      backgroundColor: UiColors.errorColor(dark),
      duration: const Duration(seconds: 3),
    );
  }
}
