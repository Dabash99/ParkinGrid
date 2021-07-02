//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';
import 'dart:ui';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.5724638,0);
    path_0.cubicTo(size.width*0.8886256,0,size.width*1.144928,size.height*0.8626748,size.width*1.144928,size.height*1.926829);
    path_0.cubicTo(size.width*1.144928,size.height*2.990984,size.width*0.8886256,size.height*3.853659,size.width*0.5724638,size.height*3.853659);
    path_0.cubicTo(size.width*0.2563019,size.height*3.853659,0,size.height*2.990984,0,size.height*1.926829);
    path_0.cubicTo(0,size.height*0.8626748,size.width*0.2563019,0,size.width*0.5724638,0);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.5724638,size.height*0.008130081);
    path_1.cubicTo(size.width*0.5337852,size.height*0.008130081,size.width*0.4951316,size.height*0.02124544,size.width*0.4575766,size.height*0.04711145);
    path_1.cubicTo(size.width*0.4209774,size.height*0.07231897,size.width*0.3849771,size.height*0.1099330,size.width*0.3505760,size.height*0.1589078);
    path_1.cubicTo(size.width*0.3167988,size.height*0.2069943,size.width*0.2842205,size.height*0.2665122,size.width*0.2537461,size.height*0.3358092);
    path_1.cubicTo(size.width*0.2235605,size.height*0.4044485,size.width*0.1951752,size.height*0.4832769,size.width*0.1693788,size.height*0.5701043);
    path_1.cubicTo(size.width*0.1435823,size.height*0.6569311,size.width*0.1201622,size.height*0.7524719,size.width*0.09976941,size.height*0.8540721);
    path_1.cubicTo(size.width*0.07918117,size.height*0.9566447,size.width*0.06149830,size.height*1.066298,size.width*0.04721173,size.height*1.179987);
    path_1.cubicTo(size.width*0.03266125,size.height*1.295777,size.width*0.02148607,size.height*1.416948,size.width*0.01399688,size.height*1.540136);
    path_1.cubicTo(size.width*0.006312052,size.height*1.666540,size.width*0.002415459,size.height*1.796643,size.width*0.002415459,size.height*1.926829);
    path_1.cubicTo(size.width*0.002415459,size.height*2.057016,size.width*0.006312052,size.height*2.187118,size.width*0.01399688,size.height*2.313523);
    path_1.cubicTo(size.width*0.02148607,size.height*2.436710,size.width*0.03266125,size.height*2.557882,size.width*0.04721173,size.height*2.673671);
    path_1.cubicTo(size.width*0.06149830,size.height*2.787360,size.width*0.07918117,size.height*2.897014,size.width*0.09976941,size.height*2.999586);
    path_1.cubicTo(size.width*0.1201622,size.height*3.101186,size.width*0.1435823,size.height*3.196727,size.width*0.1693788,size.height*3.283554);
    path_1.cubicTo(size.width*0.1951752,size.height*3.370382,size.width*0.2235605,size.height*3.449210,size.width*0.2537461,size.height*3.517849);
    path_1.cubicTo(size.width*0.2842205,size.height*3.587146,size.width*0.3167988,size.height*3.646664,size.width*0.3505760,size.height*3.694751);
    path_1.cubicTo(size.width*0.3849771,size.height*3.743726,size.width*0.4209774,size.height*3.781340,size.width*0.4575766,size.height*3.806547);
    path_1.cubicTo(size.width*0.4951316,size.height*3.832413,size.width*0.5337852,size.height*3.845528,size.width*0.5724638,size.height*3.845528);
    path_1.cubicTo(size.width*0.6111424,size.height*3.845528,size.width*0.6497960,size.height*3.832413,size.width*0.6873510,size.height*3.806547);
    path_1.cubicTo(size.width*0.7239501,size.height*3.781340,size.width*0.7599504,size.height*3.743726,size.width*0.7943515,size.height*3.694751);
    path_1.cubicTo(size.width*0.8281287,size.height*3.646664,size.width*0.8607070,size.height*3.587146,size.width*0.8911815,size.height*3.517849);
    path_1.cubicTo(size.width*0.9213670,size.height*3.449210,size.width*0.9497524,size.height*3.370382,size.width*0.9755487,size.height*3.283554);
    path_1.cubicTo(size.width*1.001345,size.height*3.196727,size.width*1.024765,size.height*3.101186,size.width*1.045158,size.height*2.999586);
    path_1.cubicTo(size.width*1.065746,size.height*2.897014,size.width*1.083429,size.height*2.787360,size.width*1.097716,size.height*2.673671);
    path_1.cubicTo(size.width*1.112266,size.height*2.557882,size.width*1.123441,size.height*2.436710,size.width*1.130931,size.height*2.313523);
    path_1.cubicTo(size.width*1.138615,size.height*2.187118,size.width*1.142512,size.height*2.057016,size.width*1.142512,size.height*1.926829);
    path_1.cubicTo(size.width*1.142512,size.height*1.796643,size.width*1.138615,size.height*1.666540,size.width*1.130931,size.height*1.540136);
    path_1.cubicTo(size.width*1.123441,size.height*1.416948,size.width*1.112266,size.height*1.295777,size.width*1.097716,size.height*1.179987);
    path_1.cubicTo(size.width*1.083429,size.height*1.066298,size.width*1.065746,size.height*0.9566447,size.width*1.045158,size.height*0.8540721);
    path_1.cubicTo(size.width*1.024765,size.height*0.7524719,size.width*1.001345,size.height*0.6569311,size.width*0.9755487,size.height*0.5701043);
    path_1.cubicTo(size.width*0.9497524,size.height*0.4832769,size.width*0.9213670,size.height*0.4044485,size.width*0.8911815,size.height*0.3358092);
    path_1.cubicTo(size.width*0.8607070,size.height*0.2665122,size.width*0.8281287,size.height*0.2069943,size.width*0.7943515,size.height*0.1589078);
    path_1.cubicTo(size.width*0.7599504,size.height*0.1099330,size.width*0.7239501,size.height*0.07231897,size.width*0.6873510,size.height*0.04711145);
    path_1.cubicTo(size.width*0.6497960,size.height*0.02124544,size.width*0.6111424,size.height*0.008130081,size.width*0.5724638,size.height*0.008130081);
    path_1.moveTo(size.width*0.5724638,0);
    path_1.cubicTo(size.width*0.8886268,0,size.width*1.144928,size.height*0.8626709,size.width*1.144928,size.height*1.926829);
    path_1.cubicTo(size.width*1.144928,size.height*2.990988,size.width*0.8886268,size.height*3.853659,size.width*0.5724638,size.height*3.853659);
    path_1.cubicTo(size.width*0.2563008,size.height*3.853659,0,size.height*2.990988,0,size.height*1.926829);
    path_1.cubicTo(0,size.height*0.8626709,size.width*0.2563008,0,size.width*0.5724638,0);
    path_1.close();

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path_1,paint_1_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}