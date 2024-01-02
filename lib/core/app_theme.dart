import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFF9EA1D4); // #FD8A8A
final Color secondaryColor = Color.fromRGBO(253, 138, 138, 1); // #9EA1D4
final Color accentColor = Color(0xFFF1F7B5); // #F1F7B5
final Color backgroundColor = Color(0xFFDFEBEB); // #DFEBEB
final Color textBackgroundColor = Color(0xFFFFFBED); // #FFFBED
final Color additionalColor = Color(0xFFA8D1D1); // #A8D1D1
final Color acceptanceColor = Color.fromRGBO(178, 219, 154, 1);

final appTheme = ThemeData(
    fontFamily: GoogleFonts.chewy().fontFamily,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: GoogleFonts.chewy().fontFamily,
      ),
      bodyMedium: TextStyle(
        fontFamily: GoogleFonts.chewy().fontFamily,
        fontWeight: FontWeight.w100,
      ),
      bodySmall: TextStyle(
        fontFamily: GoogleFonts.chewy().fontFamily,
        fontWeight: FontWeight.w100,
      ),
      labelLarge: TextStyle(
        fontFamily: GoogleFonts.chewy().fontFamily,
        fontWeight: FontWeight.w100,
      ),

      //architectsDaughter

      // Add more text styles as needed
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primaryColor),
      iconColor: secondaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ));

BoxDecoration getContainerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );
}
