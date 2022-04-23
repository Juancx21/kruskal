import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kruskal/shared/utils/others/globalvariables.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final String icon;
  final bool deactivate;
  final Color? bgcolor;
  final Color? textColor;
  final VoidCallback? ontap;
  final bool bold;
  const SimpleButton(
      {Key? key,
      this.text = "Simple button",
      this.icon = "",
      this.deactivate = false,
      this.bgcolor,
      this.textColor,
      this.ontap,
      this.bold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color deactivateText = deactivate
        ? UiColors.container3Color(false)
        : textColor ?? UiColors.white;
    return GestureDetector(
      onTap: deactivate ? null : ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiSpacing.microSpaceLarge,
            horizontal: UiSpacing.macroSpaceSmall),
        decoration: BoxDecoration(
            color: deactivate
                ? UiColors.container1Color(false)
                : bgcolor ?? UiColors.coreOutline1Color(false),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: icon.isEmpty ? TextAlign.center : TextAlign.left,
              style: bold
                  ? UiFonts.txtSubtitle1(deactivateText)
                  : UiFonts.txtbody1(deactivateText),
            ),
            icon.isEmpty
                ? const SizedBox()
                : Container(
                    margin: UiSpacing.leftMicromedium(),
                    child: SvgPicture.asset(
                      iconpath + "$icon.svg",
                      color: deactivate
                          ? UiColors.container3Color(false)
                          : textColor ?? UiColors.white,
                      height: 16,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
