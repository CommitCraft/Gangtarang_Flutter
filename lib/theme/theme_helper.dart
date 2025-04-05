import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";

LightCodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
class ThemeHelper {

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors(),
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorscheme = {
    'lightCode': Colorschemes.lightCodeColorScheme,
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData get _getThemeData{
    var colorscheme = _supportedColorscheme[_appTheme] ?? Colorschemes.lightCodeColorScheme;

    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorscheme,
      textTheme: TextThemes.textTheme(colorscheme),
      scaffoldBackgroundColor: appTheme.blueGray50,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: appTheme.whiteA700,
          side: BorderSide(
            color: appTheme.indigo100,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: 4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorscheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appTheme.indigo50;
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorscheme.onPrimary.withOpacity(1);
          }
          return Colors.transparent;
        }),
        side: BorderSide(
          color: colorscheme.onPrimary.withOpacity(1),
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.indigo50,
      ),
    );
  }

  /// Returns the lightcode colors for the current theme.
  LightCodeColors themeColor() => getThemeColors();

  ThemeData themeData() => _getThemeData;
}


class TextThemes {
  static TextTheme textTheme(ColorScheme colorscheme) => TextTheme(
    bodyLarge: TextStyle(
      color: colorscheme.errorContainer.withOpacity(1),
      fontSize: 16.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: colorscheme.onPrimary.withOpacity(0.8),
      fontSize: 13.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: colorscheme.errorContainer.withOpacity(0.7),
      fontSize: 12.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: appTheme.black900,
      fontSize: 35.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 28.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: colorscheme.errorContainer.withOpacity(1),
      fontSize: 24.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      color: colorscheme.onPrimary,
      fontSize: 12.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: colorscheme.onPrimary.withOpacity(1),
      fontSize: 10.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: appTheme.black900,
      fontSize: 22.fSize,
      fontFamily: 'Jsot',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: colorscheme.onPrimary.withOpacity(1),
      fontSize: 16.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: colorscheme.onPrimary.withOpacity(1),
      fontSize: 14.fSize,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w500,
    ),
  );
}

/// Class containing the supported color schemes.
class Colorschemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: const Color(0XFFFD9800),
    primaryContainer: const Color(0XFF242638),
    secondaryContainer: const Color(0XFF59BD56),
    errorContainer: const Color(0X19000000),
    onError: const Color(0XFF9C9C9C),
    onPrimary: const Color(0X7F131921),
    onPrimaryContainer: const Color(0XFFFFF4F4),
  );
}

class LightCodeColors {
  // Amber
  Color get amber300 => const Color(0xFFFFCC4A);
  Color get amber400 => const Color(0xFFFFE019);
  Color get amber500 => const Color(0xFFFFBC09);
  Color get amber600 => const Color(0xFFFFB700);
  Color get amber60019 => const Color(0X19FFB880);
  Color get amberA400 => const Color(0XFFFFBBF00);
  Color get amberA700 => const Color(0XFFFFA900);

  // Black
  Color get black900 => const Color(0XFF0B0C0B);
  Color get black90001 => const Color(0XFFBA0C0B);

  // BlueGray
  Color get blueGray100 => const Color(0XFFD9D9D9);
  Color get blueGray400 => const Color(0XFF7D8990);
  Color get blueGray50 => const Color(0XFFECF2F8);
  Color get blueGray800 => const Color(0XFF395E40);
  Color get blueGray900 => const Color(0XFF1E2733);

  // Cyan
  Color get cyan200 => const Color(0XFF8AE7EC);
  Color get cyan50 => const Color(0XFFCDFFFF);

  // DeepOrange
  Color get deepOrange600 => const Color(0XFFF1511B);
  Color get deepOrange60001 => const Color(0XFFFF421D);
  Color get deepOrangeA200 => const Color(0XFFFF6536);
  Color get deepOrangeA700 => const Color(0XFFDE2910);

  // Gray
  Color get gray100 => const Color(0XFFF3F6F9);
  Color get gray10001 => const Color(0XFFF2F3F8);
  Color get gray10002 => const Color(0XFFF5F7F9);
  Color get gray300 => const Color(0XFFE3E4E8);
  Color get gray30001 => const Color(0XFFFDDDDD);
  Color get gray400 => const Color(0XFFAFAFAF);
  Color get gray50 => const Color(0XFFF5F8FA);
  Color get gray5001 => const Color(0XFFF8FAFC);
  Color get gray5002 => const Color(0XFFF9FCFF);
  Color get gray90082 => const Color(0XB2051620);

  // Green
  Color get green700 => const Color(0XFF219653);
  Color get green70001 => const Color(0XFF159E42);
  Color get green900 => const Color(0XFF0C5908);
  Color get greenA700 => const Color(0XFF009449);

  // Indigo
  Color get indigo100 => const Color(0XFFC1CDDB);
  Color get indigo200 => const Color(0XFFABB2DB);
  Color get indigo0 => const Color(0xFFFAFDFF);
  Color get indigo50 => const Color(0XFFDFE7F4);
  Color get indigo5001 => const Color(0XFFE4ECF4);
  Color get indigo700 => const Color(0XFF2D4F9E);
  Color get indigo800 => const Color(0XFF214688);
  Color get indigo900 => const Color(0XFF00189A);
  Color get indigo90019 => const Color(0X19092460);

  // LightBlue
  Color get lightBlue500 => const Color(0XFF0BADEF);
  Color get lightBlue700 => const Color(0XFF0033CA);
  Color get lightBlue900 => const Color(0XFF005385);
  Color get lightBlue90001 => const Color(0XFF815294);

  // LightGreen
  Color get lightGreen600 => const Color(0XFF80CC28);
  Color get lightGreen700 => const Color(0XFF6DA544);

  // Orange
  Color get orange50 => const Color(0XFFFFF1DE);
  Color get orange500 => const Color(0XFFFF9810);
  Color get orangeA200 => const Color(0XFFFF9F48);
  Color get orangeA700 => const Color(0XFFFF6900);

  // Pink
  Color get pink800 => const Color(0XFFA70852);
  Color get pinkA700 => const Color(0XFFCD005D);

  // Red
  Color get red400 => Color(0XFFE85757);
  Color get red500 => Color(0XFF303030);
  Color get red700 => Color(0XFFE2B37);
  Color get red70001 => Color(0XFFE2B37);
  Color get red800 => Color(0XFF60C03C);
  Color get red900 => Color(0XFFB0A030);
  Color get red90001 => Color(0XFFAE1C28);
  Color get redA100 => Color(0XFFCB0882);
  Color get redA700 => Color(0XFFCB0882);
  Color get redA70001 => Color(0XFFFF0000);
  Color get redA70002 => Color(0XFFE70000);
  Color get redA70003 => Color(0XFFD80027);
  Color get redA70004 => Color(0XFFDD0000);

// Teal
  Color get teal150 => Color(0XFFDBE6F1);

// White
  Color get whiteA700 => Color(0XFFFFFFFF);

// Yellow
  Color get yellowA700 => Color(0XFFFFD600);
  Color get yellowA70001 => Color(0XFFFFCE00);
}
