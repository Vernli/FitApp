import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: grey,
  colorScheme: ColorScheme.fromSeed(
    seedColor: lightRed,
    brightness: Brightness.dark,
    surface: lightRed,
    background: grey,
    primary: lightRed,
    onPrimary: darkRed,
    secondary: lightGrey,
    onSecondary: grey,
    error: lightRed,
    primaryContainer: darkerRed,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

TextStyle get dietTitleStyle => GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey[200],
    );
TextStyle get dietSubtitileStyle => GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.grey[300],
    );

TextStyle get dietTileSummary => GoogleFonts.lato(
      fontSize: 12,
      color: Colors.grey[300],
    );

TextStyle get dietInputLabel => GoogleFonts.lato(
      fontSize: 16,
      color: Colors.white,
    );
TextStyle get dietDialog => GoogleFonts.lato(
      fontSize: 16,
      color: Colors.white,
    );
TextStyle get dietInput => GoogleFonts.lato(
      fontSize: 16,
      color: Colors.white,
    );
