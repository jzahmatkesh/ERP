import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme{
  Light, Dark
}

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

bool isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

final appThemeData = {
  AppTheme.Light : ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    accentColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.grey[100],
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.grey[600], fontFamily: 'pacifico', fontSize: 14),
    ),
    fontFamily: 'orelega'
  ),
  AppTheme.Dark : ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    primaryColor: Color(0xFF294c60),
    accentColor: Colors.lightBlueAccent,
    scaffoldBackgroundColor: Colors.grey[800],
    bottomAppBarColor: Colors.grey[700],
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white70, fontFamily: 'pacifico', fontSize: 14),
    ),
    fontFamily: 'orelega'
  )
};