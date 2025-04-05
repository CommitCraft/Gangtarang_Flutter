import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber400,
      );

  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray50,
      );

  static BoxDecoration get fillBluegray100 => BoxDecoration(
        color: appTheme.blueGray100,
      );

  static BoxDecoration get fillBluegray400 => BoxDecoration(
        color: appTheme.blueGray400,
      );

  static BoxDecoration get fillDeepOrangeA => BoxDecoration(
        color: appTheme.deepOrangeA700.withOpacity(0.1),
      );

  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.3),
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10002,
      );

  static BoxDecoration get fillGray10001 => BoxDecoration(
        color: appTheme.gray10001,
      );

  static BoxDecoration get fillGray50 => BoxDecoration(
        color: appTheme.gray50,
      );

  static BoxDecoration get fillGray90082 => BoxDecoration(
        color: appTheme.gray90082,
      );

  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green900.withOpacity(0.1),
      );

  static BoxDecoration get fillGreenA => BoxDecoration(
        color: appTheme.greenA700.withOpacity(0.1),
      );

  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo900.withOpacity(0.1),
      );

  static BoxDecoration get fillIndigo800 => BoxDecoration(
        color: appTheme.indigo800.withOpacity(0.1),
      );

  static BoxDecoration get fillLightBlue => BoxDecoration(
        color: appTheme.lightBlue900.withOpacity(0.1),
      );

  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );

  static BoxDecoration get fillOrangeA => BoxDecoration(
        color: appTheme.orangeA200.withOpacity(0.2),
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );

  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red900.withOpacity(0.1),
      );

  static BoxDecoration get fillRed500 => BoxDecoration(
        color: appTheme.red500,
      );

  static BoxDecoration get fillRed600 => BoxDecoration(
        color: appTheme.red800.withOpacity(0.1),
      );

  static BoxDecoration get fillRedA => BoxDecoration(
        color: appTheme.redA70003.withOpacity(0.1),
      );

  static BoxDecoration get fillRedA700 => BoxDecoration(
        color: appTheme.redA700.withOpacity(0.1),
      );

  static BoxDecoration get fillRedA70004 => BoxDecoration(
        color: appTheme.redA70004.withOpacity(0.1),
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

// Gradient decorations
  static BoxDecoration get gradientCyanToCyan => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.73, 1),
          end: Alignment(0.73, 0),
          colors: [appTheme.cyan200, appTheme.cyan50],
        ),
      );

  static BoxDecoration get gradientCyanToCyan50 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.73, 1),
          end: Alignment(0.73, 0),
          colors: [appTheme.cyan200, appTheme.cyan50],
        ),
      );

// Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray400.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(0, 5),
          ),
        ],
      );

  static BoxDecoration get outlineBluegray400 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.blueGray400,
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get outlineErrorContainer => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.errorContainer,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(0, -5),
          ),
        ],
      );

  static BoxDecoration get outlineIndigo => BoxDecoration(
        border: Border.all(
          color: appTheme.indigo100,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.teal150,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: appTheme.whiteA700,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      );

  static BoxDecoration get outlineIndigo100 => BoxDecoration(
        border: Border.all(
          color: appTheme.indigo100,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.teal150,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: appTheme.gray5002,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      );

  static BoxDecoration get outlineIndigo50 => BoxDecoration(
        color: appTheme.gray100,
        border: Border.all(
          color: appTheme.indigo50,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlinePrimary => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get outlineRed => BoxDecoration(
        border: Border.all(
          color: appTheme.red400,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineWhiteA => BoxDecoration(
        color: appTheme.blueGray100,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 3.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get outlineWhiteA700 => BoxDecoration(
        color: appTheme.blueGray100,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 4.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder20 => BorderRadius.circular(20.h);

  static BorderRadius get circleBorder40 => BorderRadius.circular(40.h);

  // Custom borders
  static BorderRadius get customBorderLR14 => BorderRadius.horizontal(
        right: Radius.circular(14.h),
      );

  static BorderRadius get customBorderTL10 => BorderRadius.vertical(
        top: Radius.circular(10.h),
      );

  static BorderRadius get customBorderTL14 => BorderRadius.only(
        topLeft: Radius.circular(14.h),
        topRight: Radius.circular(14.h),
        bottomLeft: Radius.circular(14.h),
      );

  static BorderRadius get customBorderTL141 => BorderRadius.horizontal(
        left: Radius.circular(14.h),
      );

  static BorderRadius get customBorderTL142 => BorderRadius.only(
        topLeft: Radius.circular(14.h),
        topRight: Radius.circular(14.h),
        bottomRight: Radius.circular(14.h),
      );

  static BorderRadius get customBorderTL143 => BorderRadius.vertical(
        top: Radius.circular(14.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);

  static BorderRadius get roundedBorder16 => BorderRadius.circular(16.h);

  static BorderRadius get roundedBorder28 => BorderRadius.circular(28.h);

  static BorderRadius get roundedBorder3 => BorderRadius.circular(3.h);

  static BorderRadius get roundedBorder34 => BorderRadius.circular(34.h);

  static BorderRadius get roundedBorder44 => BorderRadius.circular(44.h);

  static BorderRadius get roundedBorder6 => BorderRadius.circular(6.h);
}
