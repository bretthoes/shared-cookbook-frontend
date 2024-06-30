/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.primary,
          minimumSize: Size(double.infinity, 60),
          textStyle: _textTheme.labelLarge,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.secondary,
        selectedItemColor: colorScheme.onSecondary,
        unselectedItemColor: colorScheme.onPrimary,
        selectedLabelStyle: _textTheme.displaySmall,
        unselectedLabelStyle: _textTheme.labelSmall,
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.primary,
        textStyle: _textTheme.labelSmall,
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: colorScheme.surface,
        unselectedLabelColor: colorScheme.surface,
        labelColor: colorScheme.surface,
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFFF2E6),
    primaryContainer: Colors.red,
    secondary: Color(0xFFE6E4BF),
    secondaryContainer: Colors.blue,
    surface: Color(0xFFFFF2E6),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFFB03D64),
    onSurface: Color(0xFF10382D),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    surface: Color(0xFF1F1929),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: Colors.amber,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineSmall: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 18.0),
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    headlineLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 22.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 16.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 18.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 20.0),
    bodySmall: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 18.0),
    labelSmall: GoogleFonts.sriracha(fontWeight: _medium, fontSize: 16.0),
    labelMedium: GoogleFonts.sriracha(fontWeight: _medium, fontSize: 18.0),
    labelLarge: GoogleFonts.sriracha(fontWeight: _medium, fontSize: 20.0),
    displaySmall: GoogleFonts.sriracha(fontWeight: _semiBold, fontSize: 16.0),
    displayMedium: GoogleFonts.sriracha(fontWeight: _semiBold, fontSize: 18.0),
    displayLarge: GoogleFonts.sriracha(fontWeight: _semiBold, fontSize: 20.0),
  );
}
