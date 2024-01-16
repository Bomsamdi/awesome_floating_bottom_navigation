import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

class CircularCorneredRectangle extends NotchedShape {
  /// Creates a [CircularCorneredRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  final Animation<double>? animation;
  final double leftCornerRadius;
  final double rightCornerRadius;

  CircularCorneredRectangle({
    required this.leftCornerRadius,
    required this.rightCornerRadius,
    this.animation,
  });

  /// Creates a [Path] that describes a rectangle with a smooth circular notch.
  ///
  /// `host` is the bounding box for the returned shape. Conceptually this is
  /// the rectangle to which the notch will be applied.
  ///
  /// `guest` is the bounding box of a circle that the notch accommodates. All
  /// points in the circle bounded by `guest` will be outside of the returned
  /// path.
  ///
  /// The notch is curve that smoothly connects the host's top edge and
  /// the guest circle.
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      if (this.rightCornerRadius > 0 || this.leftCornerRadius > 0) {
        double leftCornerRadius =
            this.leftCornerRadius * (animation?.value ?? 1);
        double rightCornerRadius =
            this.rightCornerRadius * (animation?.value ?? 1);
        return Path()
          ..moveTo(host.left, host.bottom)
          ..lineTo(host.left, host.top + leftCornerRadius)
          ..arcToPoint(
            Offset(host.left + leftCornerRadius, host.top),
            radius: Radius.circular(leftCornerRadius),
            clockwise: true,
          )
          ..lineTo(host.right - rightCornerRadius, host.top)
          ..arcToPoint(
            Offset(host.right, host.top + rightCornerRadius),
            radius: Radius.circular(rightCornerRadius),
            clockwise: true,
          )
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close();
      }
      return Path()..addRect(host);
    }

    double leftCornerRadius = this.leftCornerRadius * (animation?.value ?? 1);
    double rightCornerRadius = this.rightCornerRadius * (animation?.value ?? 1);

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    return Path()
      ..moveTo(host.left, host.bottom)
      ..lineTo(host.left, host.top + leftCornerRadius)
      ..arcToPoint(
        Offset(host.left + leftCornerRadius, host.top),
        radius: Radius.circular(leftCornerRadius),
        clockwise: true,
      )
      ..lineTo(host.right - rightCornerRadius, host.top)
      ..arcToPoint(
        Offset(host.right, host.top + rightCornerRadius),
        radius: Radius.circular(rightCornerRadius),
        clockwise: true,
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
