import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';

class ColorButton extends StatelessWidget {
  final String color;
  final ValueChanged<Color>? function;
  const ColorButton({Key? key, this.function, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(){
      switch (color) {
        case "red":
          return const Color(0xFFEB5757);
        case "green":
          return const Color(0xFF219653);
        case "purple":
          return const Color(0xFF7B61FF);
        case "blue":
          return const Color(0xFF2F80ED);
        default:
          return const Color(0xFF7B61FF);
      }
    }
    return GestureDetector(
      onTap: function != null ? () => function!(getColor()) :  null ,
      child: Container(
        height: 24,
        width: 24,
        margin: UiSpacing.leftMicromedium(),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }
}