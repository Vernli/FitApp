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
