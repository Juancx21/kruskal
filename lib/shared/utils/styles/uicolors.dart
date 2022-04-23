import 'package:flutter/material.dart';

class UiColors {
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);

  static Color bgColorLight = const Color(0xFFE7E4F1);
  static Color bgColorDark = const Color(0xFF090035);

  static Color gray8 = const Color(0xFF141414);
  static Color gray16 = const Color(0xFF292929);
  static Color gray24 = const Color(0xFF3D3D3D);
  static Color gray32 = const Color(0xFF525252);
  static Color gray40 = const Color(0xFF666666);
  static Color gray48 = const Color(0xFF7A7A7A);
  static Color gray56 = const Color(0xFF8F8F8F);
  static Color gray64 = const Color(0xFFA3A3A3);
  static Color gray72 = const Color(0xFFB8B8B8);
  static Color gray80 = const Color(0xFFCCCCCC);
  static Color gray88 = const Color(0xFFE0E0E0);
  static Color gray96 = const Color(0xFFF5F5F5);

  static Color core1 = const Color(0xFFF3F0FF);
  static Color core2 = const Color(0xFFD4CCFF);
  static Color core3 = const Color(0xFFB7A8FF);
  static Color core4 = const Color(0xFF9985FF);
  static Color core5 = const Color(0xFF7B61FF);
  static Color core6 = const Color(0xFF674DEF);
  static Color core7 = const Color(0xFF503BBA);
  static Color core8 = const Color(0xFF2C1A89);
  static Color core9 = const Color(0xFF1B0A71);
  static Color core10 = const Color(0xFF0D0052);

  static Color error = const Color(0xFFDA1E28);
  static Color darkerror = const Color(0xFFFB6060);

  static Color warning = const Color(0xFF806A00);
  static Color darkwarning = const Color(0xFFF1C21B);

  static Color success = const Color(0xFF1F7A3D);
  static Color darksuccess = const Color(0xFF2DC859);

  static Color alert = const Color(0xFF0F62FE);
  static Color darkalert = const Color(0xFF66A6FF);

  static Color errorColor(bool dark) {
    return dark ? darkerror : error;
  }

  static Color warningColor(bool dark) {
    return dark ? darkwarning : warning;
  }

  static Color successColor(bool dark) {
    return dark ? darksuccess : success;
  }

  static Color alertColor(bool dark) {
    return dark ? darkalert : alert;
  }

  /// Ui background color
  static Color cUiBackground(bool dark) {
    return dark ? bgColorDark : bgColorLight;
  }

  /// Container 1 color
  static Color container1Color(bool dark) {
    return dark ? core9 : gray96;
  }

  /// Container 2 color
  static Color container2Color(bool dark) {
    return dark ? core8 : gray88;
  }

  /// Container 3 color
  static Color container3Color(bool dark) {
    return dark ? core7 : gray80;
  }

  /// Outline 1 color
  static Color outline1Color(bool dark) {
    return dark ? white : black;
  }

  /// Outline 2 color
  static Color outline2Color(bool dark) {
    return dark ? white : gray16;
  }

  /// Outline 3 color
  static Color outline3Color(bool dark) {
    return dark ? gray80 : gray24;
  }

  /// Outline 4 color
  static Color outline4Color(bool dark) {
    return dark ? gray24 : gray80;
  }

  /// Blue container 1 color
  static Color coreContainer1Color(bool dark) {
    return dark ? core10 : core1;
  }

  /// Blue container 2 color
  static Color coreContainer2Color(bool dark) {
    return dark ? core8 : core2;
  }

  /// Blue container 3 color
  static Color coreContainer3Color(bool dark) {
    return dark ? core7 : core5;
  }

  /// Blue container 4 color
  static Color coreContainer4Color(bool dark) {
    return core6;
  }

  /// Blue container 5 color
  static Color coreContainer5Color(bool dark) {
    return dark ? core5 : core7;
  }

  /// Blue container 6 color
  static Color coreContainer6Color(bool dark) {
    return dark ? core2 : core8;
  }

  /// Blue outline 1 color
  static Color coreOutline1Color(bool dark) {
    return dark ? core5 : core6;
  }

  /// Blue outline 2 color
  static Color coreOutline2Color(bool dark) {
    return dark ? core3 : core7;
  }

  /// Blue outline 3 color
  static Color coreOutline3Color(bool dark) {
    return dark ? core2 : core8;
  }

  /// Blue outline 4 color
  static Color coreOutline4Color(bool dark) {
    return dark ? core10 : core9;
  }
}
