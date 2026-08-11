import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00696b),
      surfaceTint: Color(0xff00696b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1f2),
      onPrimaryContainer: Color(0xff004f51),
      secondary: Color(0xff6d5e0f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff8e287),
      onSecondaryContainer: Color(0xff534600),
      tertiary: Color(0xff4c5f7c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd4e3ff),
      onTertiaryContainer: Color(0xff344863),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f4949),
      outline: Color(0xff6f7979),
      outlineVariant: Color(0xffbec8c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4d6),
      primaryFixed: Color(0xff9cf1f2),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d4d6),
      onPrimaryFixedVariant: Color(0xff004f51),
      secondaryFixed: Color(0xfff8e287),
      onSecondaryFixed: Color(0xff221b00),
      secondaryFixedDim: Color(0xffdbc66f),
      onSecondaryFixedVariant: Color(0xff534600),
      tertiaryFixed: Color(0xffd4e3ff),
      onTertiaryFixed: Color(0xff051c35),
      tertiaryFixedDim: Color(0xffb4c8e9),
      onTertiaryFixedVariant: Color(0xff344863),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d3e),
      surfaceTint: Color(0xff00696b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff16797b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff403600),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7d6d1e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff233752),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5b6e8c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff0c1212),
      onSurfaceVariant: Color(0xff2e3838),
      outline: Color(0xff4a5454),
      outlineVariant: Color(0xff656f6f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4d6),
      primaryFixed: Color(0xff16797b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f60),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7d6d1e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff635403),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5b6e8c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff425672),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c7),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe3e9e9),
      surfaceContainerHigh: Color(0xffd8dedd),
      surfaceContainerHighest: Color(0xffccd3d2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003233),
      surfaceTint: Color(0xff00696b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005253),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff342c00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff564900),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff192d47),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff374a66),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff242e2e),
      outlineVariant: Color(0xff414b4b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4d6),
      primaryFixed: Color(0xff005253),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00393a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff564900),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3c3200),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff374a66),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff20334e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4baba),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f1),
      surfaceContainer: Color(0xffdde4e3),
      surfaceContainerHigh: Color(0xffcfd6d5),
      surfaceContainerHighest: Color(0xffc1c8c7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d4d6),
      surfaceTint: Color(0xff80d4d6),
      onPrimary: Color(0xff003738),
      primaryContainer: Color(0xff004f51),
      onPrimaryContainer: Color(0xff9cf1f2),
      secondary: Color(0xffdbc66f),
      onSecondary: Color(0xff393000),
      secondaryContainer: Color(0xff534600),
      onSecondaryContainer: Color(0xfff8e287),
      tertiary: Color(0xffb4c8e9),
      onTertiary: Color(0xff1d314b),
      tertiaryContainer: Color(0xff344863),
      onTertiaryContainer: Color(0xffd4e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdde4e3),
      onSurfaceVariant: Color(0xffbec8c8),
      outline: Color(0xff899392),
      outlineVariant: Color(0xff3f4949),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff00696b),
      primaryFixed: Color(0xff9cf1f2),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d4d6),
      onPrimaryFixedVariant: Color(0xff004f51),
      secondaryFixed: Color(0xfff8e287),
      onSecondaryFixed: Color(0xff221b00),
      secondaryFixedDim: Color(0xffdbc66f),
      onSecondaryFixedVariant: Color(0xff534600),
      tertiaryFixed: Color(0xffd4e3ff),
      onTertiaryFixed: Color(0xff051c35),
      tertiaryFixedDim: Color(0xffb4c8e9),
      onTertiaryFixedVariant: Color(0xff344863),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff96ebec),
      surfaceTint: Color(0xff80d4d6),
      onPrimary: Color(0xff002b2c),
      primaryContainer: Color(0xff479e9f),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff2dc82),
      onSecondary: Color(0xff2d2500),
      secondaryContainer: Color(0xffa2903f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcaddff),
      onTertiary: Color(0xff112640),
      tertiaryContainer: Color(0xff7e92b1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dede),
      outline: Color(0xffaab4b4),
      outlineVariant: Color(0xff889292),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005152),
      primaryFixed: Color(0xff9cf1f2),
      onPrimaryFixed: Color(0xff001415),
      primaryFixedDim: Color(0xff80d4d6),
      onPrimaryFixedVariant: Color(0xff003d3e),
      secondaryFixed: Color(0xfff8e287),
      onSecondaryFixed: Color(0xff161100),
      secondaryFixedDim: Color(0xffdbc66f),
      onSecondaryFixedVariant: Color(0xff403600),
      tertiaryFixed: Color(0xffd4e3ff),
      onTertiaryFixed: Color(0xff001128),
      tertiaryFixedDim: Color(0xffb4c8e9),
      onTertiaryFixedVariant: Color(0xff233752),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff3f4646),
      surfaceContainerLowest: Color(0xff040808),
      surfaceContainerLow: Color(0xff181f1f),
      surfaceContainer: Color(0xff232929),
      surfaceContainerHigh: Color(0xff2d3434),
      surfaceContainerHighest: Color(0xff383f3f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaefeff),
      surfaceTint: Color(0xff80d4d6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7cd0d2),
      onPrimaryContainer: Color(0xff000e0e),
      secondary: Color(0xfffff0b8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd7c26b),
      onSecondaryContainer: Color(0xff0f0b00),
      tertiary: Color(0xffeaf0ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb0c4e5),
      onTertiaryContainer: Color(0xff000b1d),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f1),
      outlineVariant: Color(0xffbac5c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005152),
      primaryFixed: Color(0xff9cf1f2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff80d4d6),
      onPrimaryFixedVariant: Color(0xff001415),
      secondaryFixed: Color(0xfff8e287),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffdbc66f),
      onSecondaryFixedVariant: Color(0xff161100),
      tertiaryFixed: Color(0xffd4e3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb4c8e9),
      onTertiaryFixedVariant: Color(0xff001128),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff4b5151),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2121),
      surfaceContainer: Color(0xff2b3232),
      surfaceContainerHigh: Color(0xff363d3d),
      surfaceContainerHighest: Color(0xff414848),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
