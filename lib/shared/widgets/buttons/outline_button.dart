import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class OoutlineButton extends StatelessWidget {
  final String text;
  final String icon;
  final Color? bgcolor;
  final Color? textColor;
  final VoidCallback? ontap;
  const OoutlineButton(
      {Key? key,
      this.text = "Outline button",
      this.icon = "",
      this.bgcolor,
      this.textColor,
      this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: ontap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: icon.isEmpty
                ? UiSpacing.microSpaceMedium
                : UiSpacing.microSpaceLarge,
            horizontal: UiSpacing.macroSpaceSmall),
        side: BorderSide(color: bgcolor ?? UiColors.coreOutline1Color(false)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: UiFonts.txtbody1(
                textColor ?? UiColors.coreOutline1Color(false)),
          ),
          icon.isEmpty
              ? const SizedBox()
              : SvgPicture.asset(
                  "assets/images/icons/$icon.svg",
                  color: textColor ?? UiColors.coreOutline1Color(false),
                  height: 24,
                ),
        ],
      ),
    );
  }
}
