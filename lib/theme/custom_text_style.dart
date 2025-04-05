import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get jost {
    return copyWith(
      fontFamily: 'Jost',
    );
  }

  TextStyle get lufga {
    return copyWith(
      fontFamily: 'Lufga',
    );
  }

  TextStyle get notoSerifTamilSlanted {
    return copyWith(
      fontFamily: 'NotoSerifTamilSlanted',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
///
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families.
class CustomTextStyles {
  static TextStyle get bodyLargeBluegray400 => theme.textTheme.bodyLarge!.copyWith(
    color: appTheme.blueGray400,
  );

  static TextStyle get bodyLargeBluegray900 => theme.textTheme.bodyLarge!.copyWith(
    color: appTheme.blueGray900,
  );

  static TextStyle get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
  );

  static TextStyle get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.primary,
  );

  static TextStyle get bodyMediumBluegray40014 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.blueGray400,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumBluegray40014_1 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.blueGray400,
  );

  static TextStyle get bodyMediumErrorContainer => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumErrorContainer14 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumErrorContainer14_1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(0.5),
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumErrorContainer15 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 15.fSize,
  );

  static TextStyle get bodyMediumErrorContainer1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
  );

  static TextStyle get bodyMediumErrorContainer2 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(0.7),
  );

  static TextStyle get bodyMediumErrorContainer3 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
  );

  static TextStyle get bodyMediumGreen700 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.green700,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumGreen70014 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.green700,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumLufgaRedA70003 => theme.textTheme.bodyMedium!.lufga.copyWith(
    color: appTheme.redA70003,
  );

  static TextStyle get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
  );

  static TextStyle get bodyMediumOnPrimary14 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumOnPrimary14_1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumOnPrimary15 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 15.fSize,
  );

  static TextStyle get bodyMediumOnPrimary_1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
  );

  static TextStyle get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 15.fSize,
  );

  static TextStyle get bodyMediumPrimary14 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumPrimary14_1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumPrimary15 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 15.fSize,
  );

  static TextStyle get bodyMediumPrimary_1 => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
  );

  static TextStyle get bodyMediumRed400 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.red400,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumWhiteA700 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 14.fSize,
  );

  static TextStyle get bodyMediumWhiteA70015 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 15.fSize,
  );

  static TextStyle get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
  );

  static TextStyle get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
    color: theme.colorScheme.primary,
  );

  static TextStyle get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 10.fSize,
  );

  static TextStyle get bodySmallWhiteA700_1 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.whiteA700.withOpacity(0.7),
  );

// Headline text style
  static TextStyle get headlineMediumOnPrimary => theme.textTheme.headlineMedium!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontWeight: FontWeight.w500,
  );

// Jost text style
  static TextStyle get jostOnPrimary => TextStyle(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontWeight: FontWeight.w400,
  ).jost;

// Label text style
  static TextStyle get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.black900,
  );

  static TextStyle get labelLargeBluegray400 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.blueGray400,
  );

  static TextStyle get labelLargeBluegray400_1 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.blueGray400,
  );

  static TextStyle get labelLargeErrorContainer => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 13.fSize,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelLargeErrorContainer13 => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(0.5),
    fontSize: 13.fSize,
  );

  static TextStyle get labelLargeErrorContainer13_1 => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 13.fSize,
  );

  static TextStyle get labelLargeErrorContainerSemiBold => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelLargeErrorContainer_1 => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
  );

  static TextStyle get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
  );

  static TextStyle get labelLargeOnPrimary13 => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 13.fSize,
  );

  static TextStyle get labelLargePinkA700 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.pinkA700,
  );

  static TextStyle get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 13.fSize,
  );

  static TextStyle get labelLargeWhiteA700 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.whiteA700,
  );

  static TextStyle get labelLargeWhiteA70013 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 13.fSize,
  );

  static TextStyle get labelLargeWhiteA700SemiBold => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.whiteA700,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelMediumPrimaryContainer => theme.textTheme.labelMedium!.copyWith(
    color: theme.colorScheme.primaryContainer,
  );

  static TextStyle get labelMediumRedA100 => theme.textTheme.labelMedium!.copyWith(
    color: appTheme.redA100,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelMediumWhiteA700 => theme.textTheme.labelMedium!.copyWith(
    color: appTheme.whiteA700,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelMediumWhiteA70013 => theme.textTheme.labelMedium!.copyWith(
    color: appTheme.whiteA700,
  );

// Title text style
  static TextStyle get titleLargeErrorContainer => theme.textTheme.titleLarge!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
  );

  static TextStyle get titleLargeJostErrorContainer => theme.textTheme.titleLarge!.jost.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 20.fSize,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get titleLargeJostOnPrimary => theme.textTheme.titleLarge!.jost.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 20.fSize,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get titleLargeJostOnPrimary20 => theme.textTheme.titleLarge!.jost.copyWith(
    color: theme.colorScheme.onPrimary.withOpacity(1),
    fontSize: 20.fSize,
  );

  static TextStyle get titleLargeJostWhiteA700 => theme.textTheme.titleLarge!.jost.copyWith(
    color: appTheme.whiteA700,
    fontSize: 20.fSize,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
    fontSize: 18.fSize,
  );

  static TextStyle get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 18.fSize,
  );

  static TextStyle get titleMediumErrorContainerSemiBold => theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 18.fSize,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get titleSmallErrorContainer_1 => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
  );

  static TextStyle get titleSmallGreen700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.green700,
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallPinkA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.pinkA700,
  );

  static TextStyle get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallPrimary15 => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallRedA70001 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.redA70001,
  );

  static TextStyle get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
  );

  static TextStyle get titleSmallWhiteA70015 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.blueGray400,
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallBluegray400_1 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.blueGray400,
  );

  static TextStyle get titleSmallErrorContainer => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(0.5),
    fontSize: 15.fSize,
  );

  static TextStyle get titleSmallErrorContainer15 => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.errorContainer.withOpacity(1),
    fontSize: 15.fSize,
  );

  static TextStyle get titleMediumGreen700 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.green700,
  );

  static TextStyle get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.whiteA700,
  );

  static TextStyle get titleMediumWhiteA700Bold => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 18.fSize,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleMediumWhiteA700_1 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.whiteA700,
  );
  static TextStyle get titlesSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 15.fSize,
  );

  static TextStyle get titlesSmallWhiteA700_1 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
  );

  static TextStyle get titlesSmallWhiteA700_2 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
  );

}
