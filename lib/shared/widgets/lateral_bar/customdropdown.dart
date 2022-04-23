import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class CustomDropDown extends StatelessWidget {
  final Widget dropdown;
  const CustomDropDown({Key? key, required this.dropdown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48,
        padding: UiSpacing.xMicromedium(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: UiColors.container2Color(false),
              style: BorderStyle.solid,
              width: 1),
        ),
        child: DropdownButtonHideUnderline(child: dropdown),
      ),
    );
  }
}
