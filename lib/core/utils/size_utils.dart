import 'package:flutter/material.dart'; // These are the viewport values of your Figma Design.

// These are used in the code as a reference to create your UI Responsively.

const num WIDTH = 375;
const num HEIGHT = 812;

const num STATUS_BAR_HEIGHT = 44;

extension ResponsiveExtension on num {
  double get w => ((this * Sizeutils.width) / WIDTH);
  double get h => ((this * Sizeutils.height) / HEIGHT);
  double get fSize => ((this * Sizeutils.width) / WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
  return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({Key? key, required this.builder}) : super(key: key);

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Sizeutils.setScreenSize(constraints, orientation);
            return builder(context, orientation, Sizeutils.deviceType);
          },
        );
      },
    );
  }
}

// Ignore for file: must be immutable
class Sizeutils {
  // Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  // Device's Orientation
  static late Orientation orientation;

  // Type of Device
  // This can either be mobile or tablet
  static late DeviceType deviceType;

  // Device's Height
  static late double height;

  // Device's Width
  static late double width;

  static void setScreenSize(
      BoxConstraints constraints,
      Orientation currentOrientation,
      ) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxHeight.isNonZero(defaultValue: WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }

    deviceType = DeviceType.mobile;
  }
}