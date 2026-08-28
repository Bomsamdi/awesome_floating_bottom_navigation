import 'package:flutter/material.dart';

@immutable
class AroundCustomPainter extends StatelessWidget {
  final CustomClipper<Path> clipper;

  final Shadow? shadow;

  final double borderWidth;
  final Color borderColor;

  final Widget child;

  const AroundCustomPainter({
    super.key,
    required this.clipper,
    required this.borderWidth,
    required this.borderColor,
    required this.child,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // No UniqueKey here: it forced the whole subtree to be torn down and
      // rebuilt on every single build of this widget.
      painter: _AroundCustomPainter(
        clipper: clipper,
        shadow: shadow,
        borderColor: borderColor,
        borderWidth: borderWidth,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _AroundCustomPainter extends CustomPainter {
  final CustomClipper<Path> clipper;

  final Shadow? shadow;
  final double borderWidth;
  final Color borderColor;

  const _AroundCustomPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.clipper,
    this.shadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.height == 0) return;

    final Path clipPath = clipper.getClip(size);

    if (borderColor.a > 0) {
      canvas.drawPath(
        clipPath,
        Paint()
          ..color = borderColor
          ..strokeCap = StrokeCap.square
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth,
      );
    }

    final Shadow? shadow = this.shadow;
    if (shadow != null && shadow.color.a > 0) {
      canvas.drawPath(clipPath.shift(shadow.offset), shadow.toPaint());
    }
  }

  @override
  bool shouldRepaint(_AroundCustomPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.shadow != shadow ||
      oldDelegate.clipper != clipper;
}
