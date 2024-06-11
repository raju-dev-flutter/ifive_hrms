part of 'app_theme.dart';

@immutable
class _AppBarTheme {
  // LIGHT MODE
  static final AppBarTheme _appBarLightTheme = AppBarTheme(
    toolbarHeight: 56,
    shadowColor: Colors.transparent,
    backgroundColor: _GeneratorColors.primaryLight,
    titleTextStyle: TextStyle(color: _GeneratorColors.white, fontSize: 20.sp),
    actionsIconTheme: IconThemeData(color: _GeneratorColors.white),
    iconTheme: IconThemeData(color: _GeneratorColors.white),
    centerTitle: true,
    elevation: 0,
    titleSpacing: 1,
  );

  // DARK MODE
  static final AppBarTheme _appBarDarkTheme = AppBarTheme(
    toolbarHeight: 56,
    shadowColor: Colors.transparent,
    backgroundColor: _GeneratorColors.primaryDark,
    titleTextStyle: TextStyle(color: _GeneratorColors.white, fontSize: 20.sp),
    actionsIconTheme: IconThemeData(color: _GeneratorColors.white),
    iconTheme: IconThemeData(color: _GeneratorColors.white),
    centerTitle: true,
    elevation: 0,
    titleSpacing: 1,
  );
}
