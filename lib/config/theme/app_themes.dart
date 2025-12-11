import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColorLight: const Color(0xff0eae56),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    primaryColor: const Color(0xff0eae56),
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    //fontFamily: 'Poppins',
    primaryColorDark: const Color(0xff0eae56),
    scaffoldBackgroundColor: const Color(0xFF070603),
    primaryColor: const Color(0xff0eae56),
    appBarTheme: appBarTheme().copyWith(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF1D1617)),
    titleTextStyle: TextStyle(
        color: Color(0xFF1D1617), fontSize: 18, fontWeight: FontWeight.bold),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme(
    focusColor: Color(0xff0eae56),
    fillColor: Color(0xff0eae56),
    labelStyle: TextStyle(color: Color(0xff0eae56)),
    hoverColor: Color(0xff0eae56),
    activeIndicatorBorder: BorderSide(color: Color(0xff0eae56)),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff0eae56),
        width: 2.0,
      ),
    ),
  );
}
