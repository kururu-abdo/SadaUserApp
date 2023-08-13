


import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'dart:ui' as ui;
class LabelDetectorPainter extends CustomPainter {
  LabelDetectorPainter(this.absoluteImageSize, this.labels);

  final Size? absoluteImageSize;
  final List<ImageLabel>? labels;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 23,
          textDirection: TextDirection.ltr),
    );

    builder.pushStyle(ui.TextStyle(color: Colors.green));
    for (final ImageLabel label in labels!) {
      builder.addText('Label: ${label.text}, '
          'Confidence: ${label.confidence!.toStringAsFixed(2)}\n');
    }
    builder.pop();

    canvas.drawParagraph(
      builder.build()
        ..layout(ui.ParagraphConstraints(
          width: size.width,
        )),
      const Offset(0, 0),
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
  return false;
  }
}