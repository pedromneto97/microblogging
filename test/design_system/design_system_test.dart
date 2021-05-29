import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/design_system/theme.dart';

void main() {
  group('Test design system theme', () {
    const colorScheme = ColorScheme.light();

    test('Brightnes', () {
      expect(theme.brightness, colorScheme.brightness);
    });

    test('Primary color', () {
      expect(theme.primaryColor, colorScheme.primary);
    });

    test('Primary color brightness', () {
      expect(
        theme.primaryColorBrightness,
        ThemeData.estimateBrightnessForColor(colorScheme.primary),
      );
    });

    test('Canvas color', () {
      expect(theme.canvasColor, colorScheme.background);
    });

    test('Accent color', () {
      expect(theme.accentColor, colorScheme.secondary);
    });

    test('Accent color brightness', () {
      expect(
        theme.accentColorBrightness,
        ThemeData.estimateBrightnessForColor(colorScheme.secondary),
      );
    });

    test('Scaffold background color', () {
      expect(
        theme.scaffoldBackgroundColor,
        Colors.grey.shade50,
      );
    });

    test('Bottom app bar color', () {
      expect(
        theme.bottomAppBarColor,
        colorScheme.surface,
      );
    });

    test('Card color', () {
      expect(
        theme.cardColor,
        colorScheme.surface,
      );
    });

    test('Divider color', () {
      expect(
        theme.dividerColor,
        colorScheme.onSurface.withOpacity(0.12),
      );
    });

    test('Background color', () {
      expect(
        theme.backgroundColor,
        colorScheme.background,
      );
    });

    test('Dialog background color', () {
      expect(
        theme.dialogBackgroundColor,
        colorScheme.background,
      );
    });

    test('Error color', () {
      expect(
        theme.errorColor,
        colorScheme.error,
      );
    });

    test('Indicator color', () {
      expect(
        theme.indicatorColor,
        colorScheme.onPrimary,
      );
    });

    test('Apply elevation overlay color', () {
      expect(
        theme.applyElevationOverlayColor,
        false,
      );
    });

    test('Color scheme', () {
      expect(
        theme.colorScheme,
        colorScheme,
      );
    });

    group('Elevated button theme style', () {
      test('shape', () {
        expect(
          theme.elevatedButtonTheme.style!.shape!
              .resolve({MaterialState.disabled}),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );
      });

      test('minimun size', () {
        expect(
          theme.elevatedButtonTheme.style!.minimumSize!
              .resolve({MaterialState.disabled}),
          const Size.fromHeight(48),
        );
      });
    });

    group('Outlined button theme style', () {
      test('shape', () {
        expect(
          theme.outlinedButtonTheme.style!.shape!
              .resolve({MaterialState.disabled}),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );
      });

      test('minimun size', () {
        expect(
          theme.outlinedButtonTheme.style!.minimumSize!
              .resolve({MaterialState.disabled}),
          const Size.fromHeight(48),
        );
      });

      test('Background color', () {
        expect(
          theme.outlinedButtonTheme.style!.backgroundColor!
              .resolve({MaterialState.selected}),
          Colors.white,
        );
      });
    });

    group('Card theme', () {
      test('Card shape', () {
        expect(
          theme.cardTheme.shape,
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      });

      test('Card elevation', () {
        expect(
          theme.cardTheme.shape,
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      });

      test('Card clip behavior', () {
        expect(
          theme.cardTheme.clipBehavior,
          Clip.hardEdge,
        );
      });
    });

    test('Input decoration theme', () {
      expect(theme.inputDecorationTheme.border, const OutlineInputBorder());
    });

    test('Floating action button', () {
      expect(
        theme.floatingActionButtonTheme.backgroundColor,
        colorScheme.primary,
      );
    });
  });
}
