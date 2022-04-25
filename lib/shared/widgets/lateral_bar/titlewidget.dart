import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class TitleWidget extends StatelessWidget {
  final String type;
  final String text;
  final Color? color;
  const TitleWidget(
      {Key? key, this.type = "title", this.text = "Text", this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: type == "title"
            ? UiSpacing.yMacrosmall()
            : UiSpacing.bottomMicrolarge(),
        child: title());
  }

  Widget title() {
    Color colorTemp = color ?? UiColors.outline2Color(false);
    switch (type) {
      case "title":
        return Text(
          text,
          style: UiFonts.txtH6(colorTemp),
        );
      case "subtitle":
        return Row(
          children: [
            Text(
              text,
              style: UiFonts.txtSubtitle1(colorTemp),
            ),
            const SizedBox(
              width: UiSpacing.microSpaceMedium,
            ),
            Expanded(
                child: Container(
              height: 1,
              color: UiColors.container2Color(false),
            ))
          ],
        );
      default:
        return Text(
          "Settings",
          style: UiFonts.txtSubtitle1(colorTemp),
        );
    }
  }
}
