import 'dart:async';
// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

// colors

class AppConstant {
  static const Color kRichBlack = Color(0xFF000814);
  static const Color kOxfordBlue = Color(0xFF001D3D);
  static const Color kPrussianBlue = Color(0xFF003566);
  static const Color kMikadoYellow = Color(0xFFffc300);
  static const Color kDavysGrey = Color(0xFF4B5358);
  static const Color kGrey = Color(0xFF303030);

// text style
  static final TextStyle kHeading5 =
      GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
  static final TextStyle kHeading6 = GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
  static final TextStyle kSubtitle = GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
  static final TextStyle kBodyText = GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
  static final kTextTheme = TextTheme(
    headlineSmall: AppConstant.kHeading5,
    titleLarge: AppConstant.kHeading6,
    titleMedium: AppConstant.kSubtitle,
    bodyMedium: AppConstant.kBodyText,
  );

  static const kColorScheme = ColorScheme(
    primary: kMikadoYellow,
    primaryContainer: kMikadoYellow,
    secondary: kPrussianBlue,
    secondaryContainer: kPrussianBlue,
    surface: kRichBlack,
    background: kRichBlack,
    error: Colors.red,
    onPrimary: kRichBlack,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  );
}
