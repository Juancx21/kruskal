import 'package:flutter/material.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';

class SwitchButton extends StatefulWidget {
  final int height;
  final ValueChanged<bool>? state;
  const SwitchButton({Key? key, this.height = 20, this.state})
      : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {
  late bool value;
  late AnimationController animationController;
  late Animation<double> translate;

  late double width;
  late double padding;
  late double point;

  @override
  void initState() {
    super.initState();
    value = false;
    padding = widget.height / 6;
    width = widget.height.toDouble() * 2;
    point = widget.height - widget.height / 3;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    translate = Tween<double>(begin: padding, end: width - (point + padding))
        .animate(animationController);
  }

  changeValue() {
    setState(() {
      value = !value;
    });
    if (value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    if (widget.state != null) {
      widget.state!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        BorderRadius.circular((widget.height / 2).roundToDouble());
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => GestureDetector(
        onTap: changeValue,
        child: Container(
          height: width / 2,
          width: width,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: value ? UiColors.core6 : UiColors.gray80),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                Positioned(
                  top: padding,
                  left: translate.value,
                  child: Container(
                    height: point,
                    width: point,
                    decoration: BoxDecoration(
                      color: UiColors.white,
                      borderRadius: BorderRadius.circular(point),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
