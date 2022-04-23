import 'package:flutter/material.dart';

class UiSpacing {
  // Micro spaces. Spacing (margins, paddings) for creating individual widgets
  static const double microSpaceSmall = 4;
  static const double microSpaceNormal = 8;
  static const double microSpaceMedium = 12;
  static const double microSpaceLarge = 16;

  // Macro spaces. Spaces (margins, paddings) that may be linked to containers containing other containers.
  static const double macroSpaceSmall = 24;
  static const double macroSpaceNormal = 32;
  static const double macroSpaceMedium = 48;
  static const double macroSpaceLarge = 64;
  static const double macroSpaceXLarge = 96;

  /// Returns a left widget space with a value set to [microSpaceSmall]
  static EdgeInsets leftMicrosmall() {
    return const EdgeInsets.only(left: microSpaceSmall);
  }

  /// Returns a left widget space with a value set to [microSpaceNormal]
  static EdgeInsets leftMicronormal() {
    return const EdgeInsets.only(left: microSpaceNormal);
  }

  /// Returns a left widget space with a value set to [microSpaceMedium]
  static EdgeInsets leftMicromedium() {
    return const EdgeInsets.only(left: microSpaceMedium);
  }

  /// Returns a left widget space with a value set to [microSpaceLarge]
  static EdgeInsets leftMicrolarge() {
    return const EdgeInsets.only(left: microSpaceLarge);
  }

  /// Returns a right widget space with a value set to [microSpaceSmall]
  static EdgeInsets rightMicrosmall() {
    return const EdgeInsets.only(right: microSpaceSmall);
  }

  /// Returns a right widget space with a value set to [microSpaceNormal]
  static EdgeInsets rightMicronormal() {
    return const EdgeInsets.only(right: microSpaceNormal);
  }

  /// Returns a right widget space with a value set to [microSpaceMedium]
  static EdgeInsets rightMicromedium() {
    return const EdgeInsets.only(right: microSpaceMedium);
  }

  /// Returns a right widget space with a value set to [microSpaceLarge]
  static EdgeInsets rightMicrolarge() {
    return const EdgeInsets.only(right: microSpaceLarge);
  }

  /// Returns a top widget space with a value set to [microSpaceSmall]
  static EdgeInsets topMicrosmall() {
    return const EdgeInsets.only(top: microSpaceSmall);
  }

  /// Returns a top widget space with a value set to [microSpaceNormal]
  static EdgeInsets topMicronormal() {
    return const EdgeInsets.only(top: microSpaceNormal);
  }

  /// Returns a top widget space with a value set to [microSpaceMedium]
  static EdgeInsets topMicromedium() {
    return const EdgeInsets.only(top: microSpaceMedium);
  }

  /// Returns a top widget space with a value set to [microSpaceLarge]
  static EdgeInsets topMicrolarge() {
    return const EdgeInsets.only(top: microSpaceLarge);
  }

  /// Returns a bottom widget space with a value set to [microSpaceSmall]
  static EdgeInsets bottomMicrosmall() {
    return const EdgeInsets.only(bottom: microSpaceSmall);
  }

  /// Returns a bottom widget space with a value set to [microSpaceNormal]
  static EdgeInsets bottomMicronormal() {
    return const EdgeInsets.only(bottom: microSpaceNormal);
  }

  /// Returns a bottom widget space with a value set to [microSpaceMedium]
  static EdgeInsets bottomMicromedium() {
    return const EdgeInsets.only(bottom: microSpaceMedium);
  }

  /// Returns a bottom widget space with a value set to [microSpaceLarge]
  static EdgeInsets bottomMicrolarge() {
    return const EdgeInsets.only(bottom: microSpaceLarge);
  }

  /// Returns a horizontal widget space with a value set to [microSpaceSmall]
  static EdgeInsets xMicrosmall() {
    return const EdgeInsets.symmetric(horizontal: microSpaceSmall);
  }

  /// Returns a horizontal widget space with a value set to [microSpaceNormal]
  static EdgeInsets xMicronormal() {
    return const EdgeInsets.symmetric(horizontal: microSpaceNormal);
  }

  /// Returns a horizontal widget space with a value set to [microSpaceMedium]
  static EdgeInsets xMicromedium() {
    return const EdgeInsets.symmetric(horizontal: microSpaceMedium);
  }

  /// Returns a horizontal widget space with a value set to [microSpaceLarge]
  static EdgeInsets xMicrolarge() {
    return const EdgeInsets.symmetric(horizontal: microSpaceLarge);
  }

  /// Returns a vertical widget space with a value set to [microSpaceSmall]
  static EdgeInsets yMicrosmall() {
    return const EdgeInsets.symmetric(vertical: microSpaceSmall);
  }

  /// Returns a vertical widget space with a value set to [microSpaceNormal]
  static EdgeInsets yMicronormal() {
    return const EdgeInsets.symmetric(vertical: microSpaceNormal);
  }

  /// Returns a vertical widget space with a value set to [microSpaceMedium]
  static EdgeInsets yMicromedium() {
    return const EdgeInsets.symmetric(vertical: microSpaceMedium);
  }

  /// Returns a vertical widget space with a value set to [microSpaceLarge]
  static EdgeInsets yMicrolarge() {
    return const EdgeInsets.symmetric(vertical: microSpaceLarge);
  }

  /// Returns a left widget space with a value set to [macroSpaceSmall]
  static EdgeInsets leftMacrosmall() {
    return const EdgeInsets.only(left: macroSpaceSmall);
  }

  /// Returns a left widget space with a value set to [macroSpaceNormal]
  static EdgeInsets leftMacronormal() {
    return const EdgeInsets.only(left: macroSpaceNormal);
  }

  /// Returns a left widget space with a value set to [macroSpaceMedium]
  static EdgeInsets leftMacromedium() {
    return const EdgeInsets.only(left: macroSpaceMedium);
  }

  /// Returns a left widget space with a value set to [macroSpaceLarge]
  static EdgeInsets leftMacrolarge() {
    return const EdgeInsets.only(left: macroSpaceLarge);
  }

  /// Returns a left widget space with a value set to [macroSpaceXLarge]
  static EdgeInsets leftMacroXlarge() {
    return const EdgeInsets.only(left: macroSpaceXLarge);
  }

  /// Returns a right widget space with a value set to [macroSpaceSmall]
  static EdgeInsets rightMacrosmall() {
    return const EdgeInsets.only(right: macroSpaceSmall);
  }

  /// Returns a right widget space with a value set to [macroSpaceNormal]
  static EdgeInsets rightMacronormal() {
    return const EdgeInsets.only(right: macroSpaceNormal);
  }

  /// Returns a right widget space with a value set to [macroSpaceMedium]
  static EdgeInsets rightMacromedium() {
    return const EdgeInsets.only(right: macroSpaceMedium);
  }

  /// Returns a right widget space with a value set to [macroSpaceLarge]
  static EdgeInsets rightMacrolarge() {
    return const EdgeInsets.only(right: macroSpaceLarge);
  }

  /// Returns a right widget space with a value set to [macroSpaceXLarge]
  static EdgeInsets rightMacroXlarge() {
    return const EdgeInsets.only(right: macroSpaceXLarge);
  }

  /// Returns a top widget space with a value set to [macroSpaceSmall]
  static EdgeInsets topMacrosmall() {
    return const EdgeInsets.only(top: macroSpaceSmall);
  }

  /// Returns a top widget space with a value set to [macroSpaceNormal]
  static EdgeInsets topMacronormal() {
    return const EdgeInsets.only(top: macroSpaceNormal);
  }

  /// Returns a top widget space with a value set to [macroSpaceMedium]
  static EdgeInsets topMacromedium() {
    return const EdgeInsets.only(top: macroSpaceMedium);
  }

  /// Returns a top widget space with a value set to [macroSpaceLarge]
  static EdgeInsets topMacrolarge() {
    return const EdgeInsets.only(top: macroSpaceLarge);
  }

  /// Returns a bottom widget space with a value set to [macroSpaceSmall]
  static EdgeInsets bottomMacrosmall() {
    return const EdgeInsets.only(bottom: macroSpaceSmall);
  }

  /// Returns a bottom widget space with a value set to [macroSpaceNormal]
  static EdgeInsets bottomMacronormal() {
    return const EdgeInsets.only(bottom: macroSpaceNormal);
  }

  /// Returns a bottom widget space with a value set to [macroSpaceMedium]
  static EdgeInsets bottomMacromedium() {
    return const EdgeInsets.only(bottom: macroSpaceMedium);
  }

  /// Returns a bottom widget space with a value set to [macroSpaceLarge]
  static EdgeInsets bottomMacrolarge() {
    return const EdgeInsets.only(bottom: macroSpaceLarge);
  }

  /// Returns a bottom widget space with a value set to [macroSpaceXLarge]
  static EdgeInsets bottomMacroXlarge() {
    return const EdgeInsets.only(bottom: macroSpaceXLarge);
  }

  /// Returns a horizontal widget space with a value set to [macroSpaceSmall]
  static EdgeInsets xMacrosmall() {
    return const EdgeInsets.symmetric(horizontal: macroSpaceSmall);
  }

  /// Returns a horizontal widget space with a value set to [macroSpaceNormal]
  static EdgeInsets xMacronormal() {
    return const EdgeInsets.symmetric(horizontal: macroSpaceNormal);
  }

  /// Returns a horizontal widget space with a value set to [macroSpaceMedium]
  static EdgeInsets xMacromedium() {
    return const EdgeInsets.symmetric(horizontal: macroSpaceMedium);
  }

  /// Returns a horizontal widget space with a value set to [macroSpaceLarge]
  static EdgeInsets xMacrolarge() {
    return const EdgeInsets.symmetric(horizontal: macroSpaceLarge);
  }

  /// Returns a horizontal widget space with a value set to [macroSpaceLarge]
  static EdgeInsets xMacroXlarge() {
    return const EdgeInsets.symmetric(horizontal: macroSpaceXLarge);
  }

  /// Returns a vertical widget space with a value set to [macroSpaceSmall]
  static EdgeInsets yMacrosmall() {
    return const EdgeInsets.symmetric(vertical: macroSpaceSmall);
  }

  /// Returns a vertical widget space with a value set to [macroSpaceNormal]
  static EdgeInsets yMacronormal() {
    return const EdgeInsets.symmetric(vertical: macroSpaceNormal);
  }

  /// Returns a vertical widget space with a value set to [macroSpaceMedium]
  static EdgeInsets yMacromedium() {
    return const EdgeInsets.symmetric(vertical: macroSpaceMedium);
  }

  /// Returns a vertical widget space with a value set to [macroSpaceLarge]
  static EdgeInsets yMacrolarge() {
    return const EdgeInsets.symmetric(vertical: macroSpaceLarge);
  }

  /// Returns a vertical widget space with a value set to [macroSpaceXLarge]
  static EdgeInsets yMacroXlarge() {
    return const EdgeInsets.symmetric(vertical: macroSpaceXLarge);
  }

  /// Returns a space around the widget with a value set to [macroSpaceSmall]
  static EdgeInsets allMacrosmall() {
    return const EdgeInsets.all(macroSpaceSmall);
  }

  /// Returns a space around the widget with a value set to [macroSpaceNormal]
  static EdgeInsets allMacronormal() {
    return const EdgeInsets.all(macroSpaceNormal);
  }

  /// Returns a space around the widget with a value set to [macroSpaceMedium]
  static EdgeInsets allMacromedium() {
    return const EdgeInsets.all(macroSpaceMedium);
  }

  /// Returns a space around the widget with a value set to [macroSpaceLarge]
  static EdgeInsets allMacrolarge() {
    return const EdgeInsets.all(macroSpaceLarge);
  }

  /// Returns a space around the widget with a value set to [macroSpaceXLarge]
  static EdgeInsets allMacroXlarge() {
    return const EdgeInsets.all(macroSpaceXLarge);
  }

  /// Returns a space around the widget with a value set to [microSpaceSmall]
  static EdgeInsets allMicrosmall() {
    return const EdgeInsets.all(microSpaceSmall);
  }

  /// Returns a space around the widget with a value set to [microSpaceNormal]
  static EdgeInsets allMicronormal() {
    return const EdgeInsets.all(microSpaceNormal);
  }

  /// Returns a space around the widget with a value set to [microSpaceMedium]
  static EdgeInsets allMicromedium() {
    return const EdgeInsets.all(microSpaceMedium);
  }

  /// Returns a space around the widget with a value set to [microSpaceLarge]
  static EdgeInsets allMicrolarge() {
    return const EdgeInsets.all(microSpaceLarge);
  }
}
