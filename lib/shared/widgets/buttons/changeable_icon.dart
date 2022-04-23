import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class ChangeableIcon extends StatefulWidget {
  final ValueChanged<bool>? value;
  final String firstIcon;
  final String secondIcon;
  final Color? color;
  const ChangeableIcon(
      {Key? key,
      this.value,
      this.firstIcon = "eye_open",
      this.secondIcon = "eye_close",
      this.color})
      : super(key: key);

  @override
  State<ChangeableIcon> createState() => _ChangeableIconState();
}

class _ChangeableIconState extends State<ChangeableIcon> {
  bool test = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UiSpacing.allMicromedium(),
      child: GestureDetector(
        onTap: () {
          test = !test;
          widget.value!(test);
        },
        child: SvgPicture.asset(
          "assets/images/icons/${test ? widget.firstIcon : widget.secondIcon}.svg",
          color: widget.color ?? UiColors.outline1Color(false),
        ),
      ),
    );
  }
}
