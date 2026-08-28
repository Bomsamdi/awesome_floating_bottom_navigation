## 1.0.0

Fixes for defects that made parts of the package unusable, plus tests - the
package had none.

### Breaking

* `IndexedWidgetBuilder` renamed to `AwesomeTabBuilder`. The old name is also
  declared by `package:flutter/material.dart`, so any file importing both got
  an `ambiguous_import` error and the `.builder` constructor could not be used.
* `SafeAreaValues` is now exported from the package entry point. It was part of
  the public API through `safeAreaValues:` but was never exported, so no caller
  could construct one.
* `FlexibleOuterSpace` and `CustomRoundedRectangleClipper` are now private.
* `onTap` is typed `ValueChanged<int>` instead of `Function(int)`.

### Fixed

* The splash animation no longer leaks a ticker. A new `AnimationController`
  was created on every `didUpdateWidget` and none was ever disposed, so the bar
  threw "was disposed with an active Ticker" when it left the tree mid-animation.
* The splash only replays when the selection actually changes. The guard on
  `activeIndex` was commented out, so any rebuild above the bar restarted it.
* The default splash is purple, as documented. A null `splashColor` reached the
  painter as null and was painted white - invisible on the default background.
* The bar no longer requires a `Scaffold` ancestor. It called
  `Scaffold.geometryOf(context)` for a value it never used.
* The bar's subtree is no longer rebuilt from scratch on every build: the inner
  `CustomPaint` carried a `UniqueKey()`.
* Both painters and the clipper now repaint and reclip only when their inputs
  change, instead of on every frame.

### Other

* Requires Dart 3.8 / Flutter 3.32; `flutter_lints` 6; no deprecated APIs left.
* Each item is exposed to screen readers as a button with its selected state,
  and the new `semanticLabels` gives those buttons a name.
* The published archive no longer carries the 1.5 MB demo video.
* The example app no longer leaks an `AnimationController`, and its test checks
  the bar instead of a counter that does not exist.

## 0.0.1

* Initial release.
