import 'package:flutter/material.dart';
import 'package:kruskal/domain/entities/aristc.dart';

class Drawline extends CustomPainter {
  final Aristc aristc;

  Drawline({required this.aristc});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(aristc.origin.offset.dx + 25, aristc.origin.offset.dy + 25),
        Offset(aristc.destiny.offset.dx + 25, aristc.destiny.offset.dy + 25),
        Paint()
          ..strokeWidth = 2
          ..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(Drawline oldDelegate) {
    return oldDelegate.aristc != aristc;
  }
}
