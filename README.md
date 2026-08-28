# AwesomeFloatingBottomNavigation

[![Pub Version](https://img.shields.io/pub/v/awesome_floating_bottom_navigation)](https://pub.dev/packages/awesome_floating_bottom_navigation)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pub points](https://img.shields.io/pub/points/awesome_floating_bottom_navigation)](https://pub.dev/packages/awesome_floating_bottom_navigation/score)
[![likes](https://img.shields.io/pub/likes/awesome_floating_bottom_navigation)](https://pub.dev/packages/awesome_floating_bottom_navigation/score)

A Flutter package that provides a customizable floating bottom navigation bar
with different options for item positions, including expand and center.

https://github.com/Bomsamdi/awesome_floating_bottom_navigation/assets/94292009/8d476c59-5ed9-4df5-88c3-d3a18f92003b

## Installation

```yaml
dependencies:
  awesome_floating_bottom_navigation: ^1.0.0
```

Requires Dart 3.8 / Flutter 3.32 or newer.

## Usage

```dart
import 'package:awesome_floating_bottom_navigation/awesome_floating_bottom_navigation.dart';
import 'package:flutter/material.dart';

AwesomeFloatingBottomNavigation(
  icons: const [Icons.dashboard, Icons.search, Icons.account_circle],
  activeIndex: _index,
  onTap: (index) => setState(() => _index = index),
  semanticLabels: const ['Dashboard', 'Search', 'Account'],
  backgroundColor: Colors.black87,
  splashColor: Colors.green.shade400,
  cornerRadius: 32,
  padding: const EdgeInsets.all(16),
  navigationBarType: NavigationBarType.center,
)
```

With custom tab widgets instead of icons:

```dart
AwesomeFloatingBottomNavigation.builder(
  itemCount: 3,
  activeIndex: _index,
  onTap: (index) => setState(() => _index = index),
  tabBuilder: (int index, bool isActive) => Icon(
    _icons[index],
    color: isActive ? Colors.green : Colors.grey,
  ),
)
```

A full app is in the `/example` folder.

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `icons` / `itemCount` + `tabBuilder` | — | required | Icons, or an item count with a builder. Between 2 and 5 items. |
| `activeIndex` | `int` | required | Index of the selected item. |
| `onTap` | `ValueChanged<int>` | required | Called with the tapped index. |
| `navigationBarType` | `NavigationBarType` | `center` | `center` groups the items in the middle, `expand` stretches them. |
| `outerFlex` / `itemFlex` | `int` | `4` / `3` | Flex of the outer space and of each item, in `center` layout. |
| `height` | `double?` | `56` | Bar height. |
| `iconSize` | `double?` | `24` | Icon size. |
| `backgroundColor` | `Color?` | `Colors.white` | Bar background. |
| `backgroundGradient` | `Gradient?` | `null` | Background gradient; overrides `backgroundColor`. |
| `blurEffect` | `bool` | `false` | Blurs what is behind the bar. Needs a translucent background. |
| `activeColor` / `inactiveColor` | `Color?` | `deepPurpleAccent` / `black` | Icon colors. |
| `splashColor` | `Color?` | `Colors.purple` | Color of the selection ripple. |
| `splashRadius` | `double` | `24` | Maximum ripple radius. |
| `splashSpeedInMilliseconds` | `int?` | `300` | Ripple duration. |
| `scaleFactor` | `double` | `1` | Icon scale bump on selection. `0` disables it. |
| `cornerRadius` | `double?` | `0` | Corner radius of the bar. |
| `elevation` | `double?` | `8` | Material elevation. |
| `padding` | `EdgeInsets?` | `EdgeInsets.zero` | Padding around the bar. |
| `shadow` | `Shadow?` | `null` | Shadow painted around the bar. |
| `borderColor` / `borderWidth` | `Color?` / `double?` | `transparent` / `2` | Border around the bar. |
| `safeAreaValues` | `SafeAreaValues` | all sides `true` | Which system intrusions to avoid. |
| `semanticLabels` | `List<String>?` | `null` | Screen reader label per item. |

## Accessibility

Each item is exposed to screen readers as a button carrying its selected state.
Icons have no text of their own, so pass `semanticLabels` — one entry per item —
to give them a name.

## Migrating from 0.0.1

Three renames, all of them because the old names could not actually be used:

- `IndexedWidgetBuilder` is now **`AwesomeTabBuilder`**. The old name collided
  with `IndexedWidgetBuilder` from `package:flutter/material.dart`, so importing
  both made the name ambiguous and the `.builder` constructor unusable.
- `SafeAreaValues` is now exported. It was part of the public API but never
  exported, so `safeAreaValues:` could not be given a value.
- `FlexibleOuterSpace` and `CustomRoundedRectangleClipper` are now private —
  they were internals that leaked into the public API.

## Issues and Bugs

Report any issues or bugs on the
[GitHub issues page](https://github.com/Bomsamdi/awesome_floating_bottom_navigation/issues).

## License

This package is licensed under the MIT License.
