import 'package:flutter/material.dart';
import 'package:kruskal/domain/entities/aristc.dart';

class Drawline extends CustomPainter {
  final Aristc aristc;

  Drawline({required this.aristc});

  @override
  void paint(Canvas canvas, Size size) {
    double originx = aristc.origin.offset.dx + 25;
    double originy = aristc.origin.offset.dy + 25;
    double destinyx = aristc.destiny.offset.dx + 25;
    double destinyy = aristc.destiny.offset.dy + 25;

    canvas.drawLine(
        Offset(originx, originy),
        Offset(destinyx, destinyy),
        Paint()
          ..strokeWidth = 2
          ..color = Colors.redAccent);

    final textPainter = TextPainter(
        text: TextSpan(
          text: aristc.weight.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(originx + (((destinyx - originx) / 2) - (textPainter.width / 2)),
            originy + (((destinyy - originy) / 2) - (textPainter.height / 2))));
  }

  @override
  bool shouldRepaint(Drawline oldDelegate) {
    return oldDelegate.aristc != aristc;
  }
}
