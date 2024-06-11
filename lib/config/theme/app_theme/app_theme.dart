import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config.dart';

part 'app_bar_theme.dart';
part 'color_scheme.dart';
part 'generator_colors.dart';
part 'text_theme.dart';

String _appTheme = "primary";

@immutable
class GeneratorTheme {
  // LIGHT MODE
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _ColorScheme._lightColorScheme,
    textTheme: _TextTheme._textLightTheme,
    fontFamily: 'Roboto',
    appBarTheme: _AppBarTheme._appBarLightTheme,
    scaffoldBackgroundColor: _ColorScheme._lightColorScheme.background,
  );

  // DARK MODE
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _ColorScheme._darkColorScheme,
    textTheme: _TextTheme._textDarkTheme,
    fontFamily: 'Roboto',
    appBarTheme: _AppBarTheme._appBarDarkTheme,
    scaffoldBackgroundColor: _ColorScheme._darkColorScheme.background,
  );

  final Map<String, ColorVariable> _supportedCustomColor = {
    'primary': ColorVariable()
  };

  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  ColorVariable _getThemeColors() {
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }

    return _supportedCustomColor[_appTheme] ?? ColorVariable();
  }

  ColorVariable themeColor() => _getThemeColors();
}
