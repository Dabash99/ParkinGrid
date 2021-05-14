
import 'package:flutter/material.dart';
import 'package:parking_gird/modules/login/login_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'dart:async';

import 'package:parking_gird/shared/styles/colors.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            ()=> navigateAndFinish(context, LoginScreen()));
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultColor.withOpacity(0.60),
        body: Container(
          child: Center(
            child: Image(
                image: AssetImage(
                  'assets/images/logo_splash.png',
                ),height: 300,width: 300,
                fit: BoxFit.cover,),
          ),
        ));
  }
}
