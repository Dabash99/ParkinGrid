
import 'package:flutter/material.dart';
import 'package:parking_gird/modules/login/login_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'dart:async';

import 'package:parking_gird/shared/styles/colors.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            ()=> navigateAndFinish(context, LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultColor,
        body: WidgetCircularAnimator(
          innerColor: Colors.white,
          outerColor: Colors.white,
          child: Center(
            child: Image(
                image: AssetImage(
                  'assets/images/oie_221049429DjEMstz.gif',
                ),height: 300,width: 300,
                fit: BoxFit.cover,),
          ),
        ));
  }
}
