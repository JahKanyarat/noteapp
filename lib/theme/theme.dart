import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlueAccent,
    brightness: Brightness.light),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.acme(fontSize: 50, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.lato(fontSize: 20)
  )
);

ThemeData darkmode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlueAccent,
    brightness: Brightness.dark),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.acme(fontSize: 50, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.lato(fontSize: 20)
  )
);