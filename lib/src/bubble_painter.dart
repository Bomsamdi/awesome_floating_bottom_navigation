import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  final double bubbleRadius;
  final double maxBubbleRadius;
  final Color bubbleColor;
  final Color endColor;

  BubblePainter({
    required this.bubbleRadius,
    required this.maxBubbleRadius,
    required this.bubbleColor,
  }) : endColor = Color.lerp(bubbleColor, Colors.white, 0.8)!;

  @override
  void paint(Canvas canvas, Size size) {
    if (bubbleRadius == maxBubbleRadius) return;

    final double animationProgress = bubbleRadius / maxBubbleRadius;

    final double strokeWidth = bubbleRadius < maxBubbleRadius * 0.5
        ? bubbleRadius
        : maxBubbleRadius - bubbleRadius;

    final Paint paint = Paint()
      ..color = Color.lerp(bubbleColor, endColor, animationProgress)!
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      bubbleRadius,
      paint,
    );
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) =>
      oldDelegate.bubbleRadius != bubbleRadius ||
      oldDelegate.maxBubbleRadius != maxBubbleRadius ||
      oldDelegate.bubbleColor != bubbleColor;
}
