// Created by AMIT JANGID on 6/22/2021.

import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeData() {
  return ThemeData(
    hintColor: kDarkGreyColor,
    focusColor: kPrimaryColor,
    primaryColor: kPrimaryColor,
    buttonTheme: _buttonThemeData(),
    primaryColorDark: kPrimaryDarkColor,
    primaryColorLight: kPrimaryLightColor,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: _inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimaryDarkColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: kPrimaryDarkColor),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, systemOverlayStyle: SystemUiOverlayStyle.dark),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: ZoomPageTransitionsBuilder()},
    ),
  );
}

ButtonThemeData _buttonThemeData() {
  return const ButtonThemeData(
    height: 48,
    buttonColor: kPrimaryColor,
    splashColor: Colors.white70,
    textTheme: ButtonTextTheme.primary,
  );
}

InputDecorationTheme _inputDecorationTheme() {
  const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    gapPadding: 5,
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(3)),
  );

  return const InputDecorationTheme(
    focusColor: kPrimaryColor,
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
  );
}
