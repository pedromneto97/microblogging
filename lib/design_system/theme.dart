import 'package:flutter/material.dart';

const _colorScheme = ColorScheme.light();

final theme = ThemeData(
  brightness: _colorScheme.brightness,
  primaryColor: _colorScheme.primary,
  primaryColorBrightness:
      ThemeData.estimateBrightnessForColor(_colorScheme.primary),
  canvasColor: _colorScheme.background,
  accentColor: _colorScheme.secondary,
  accentColorBrightness:
      ThemeData.estimateBrightnessForColor(_colorScheme.secondary),
  scaffoldBackgroundColor: Colors.grey.shade50,
  bottomAppBarColor: _colorScheme.surface,
  cardColor: _colorScheme.surface,
  dividerColor: _colorScheme.onSurface.withOpacity(0.12),
  backgroundColor: _colorScheme.background,
  dialogBackgroundColor: _colorScheme.background,
  errorColor: _colorScheme.error,
  indicatorColor: _colorScheme.onPrimary,
  applyElevationOverlayColor: false,
  colorScheme: _colorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(48)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(48)),
    ),
  ),
);
