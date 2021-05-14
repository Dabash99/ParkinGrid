import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parking_gird/shared/styles/colors.dart';


ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('078547'),
    accentColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
        elevation: 2
    ),
    elevatedButtonTheme:ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xff078547),
        elevation: 2,
      ),
    ),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        elevation: 15,
        backgroundColor: Colors.white),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600)),
    fontFamily: 'Jannah');