part of 'app_theme.dart';

@immutable
class _ColorScheme {
  // LIGHT MODE
  static final ColorScheme _lightColorScheme = ColorScheme.light(
    // Primary colors
    primary: _GeneratorColors.primaryLight,
    primaryContainer: _GeneratorColors.primaryContainerLight,
    secondary: _GeneratorColors.secondaryLight,
    secondaryContainer: _GeneratorColors.secondaryContainerLight,
    tertiary: _GeneratorColors.tertiaryLight,
    tertiaryContainer: _GeneratorColors.tertiaryContainerLight,

    // Background colors
    background: _GeneratorColors.backgroundLight,

    // Surface colors
    surface: _GeneratorColors.surfaceLight,
    surfaceTint: _GeneratorColors.surfaceTintLight,
    surfaceVariant: _GeneratorColors.surfaceVariantLight,

    // Error colors
    error: _GeneratorColors.errorLight,
    errorContainer: _GeneratorColors.errorContainerLight,
    onError: _GeneratorColors.onErrorLight,
    onErrorContainer: _GeneratorColors.onErrorContainerLight,

    // On colors(text colors)
    onBackground: _GeneratorColors.onBackgroundLight,
    onInverseSurface: _GeneratorColors.onInverseSurfaceLight,
    onPrimary: _GeneratorColors.onPrimaryLight,
    onPrimaryContainer: _GeneratorColors.onPrimaryContainerLight,
    onSecondary: _GeneratorColors.onSecondaryLight,
    onSecondaryContainer: _GeneratorColors.onSecondaryContainerLight,
    onTertiary: _GeneratorColors.onTertiaryLight,
    onTertiaryContainer: _GeneratorColors.onTertiaryContainerLight,

    // Other colors
    outline: _GeneratorColors.outlineLight,
    outlineVariant: _GeneratorColors.outlineVariantLight,
    scrim: _GeneratorColors.scrimLight,
    shadow: _GeneratorColors.shadowLight,

    // Inverse colors
    inversePrimary: _GeneratorColors.inversePrimaryLight,
    inverseSurface: _GeneratorColors.inverseSurfaceLight,

    // Pending colors
    onSurface: _GeneratorColors.onSurfaceLight,
    onSurfaceVariant: _GeneratorColors.onSurfaceVariantLight,
  );

  // DARK MODE
  static final ColorScheme _darkColorScheme = ColorScheme.dark(
    // Primary colors
    primary: _GeneratorColors.primaryDark,
    primaryContainer: _GeneratorColors.primaryContainerDark,
    secondary: _GeneratorColors.secondaryDark,
    secondaryContainer: _GeneratorColors.secondaryContainerDark,
    tertiary: _GeneratorColors.tertiaryDark,
    tertiaryContainer: _GeneratorColors.tertiaryContainerDark,

    // Background colors
    background: _GeneratorColors.backgroundDark,

    // Surface colors
    surface: _GeneratorColors.surfaceDark,
    surfaceTint: _GeneratorColors.surfaceTintDark,
    surfaceVariant: _GeneratorColors.surfaceVariantDark,

    // Error colors
    error: _GeneratorColors.errorDark,
    errorContainer: _GeneratorColors.errorContainerDark,
    onError: _GeneratorColors.onErrorDark,
    onErrorContainer: _GeneratorColors.onErrorContainerDark,

    // On colors(text colors)
    onBackground: _GeneratorColors.onBackgroundDark,
    onInverseSurface: _GeneratorColors.onInverseSurfaceDark,
    onPrimary: _GeneratorColors.onPrimaryDark,
    onPrimaryContainer: _GeneratorColors.onPrimaryContainerDark,
    onSecondary: _GeneratorColors.onSecondaryDark,
    onSecondaryContainer: _GeneratorColors.onSecondaryContainerDark,
    onTertiary: _GeneratorColors.onTertiaryDark,
    onTertiaryContainer: _GeneratorColors.onTertiaryContainerDark,

    // Other colors
    outline: _GeneratorColors.outlineDark,
    outlineVariant: _GeneratorColors.outlineVariantDark,
    scrim: _GeneratorColors.scrimDark,
    shadow: _GeneratorColors.shadowDark,

    // Inverse colors
    inversePrimary: _GeneratorColors.inversePrimaryDark,
    inverseSurface: _GeneratorColors.inverseSurfaceDark,

    // Pending colors
    onSurface: _GeneratorColors.onSurfaceDark,
    onSurfaceVariant: _GeneratorColors.onSurfaceVariantDark,
  );
}
