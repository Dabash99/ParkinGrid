import 'package:flutter/material.dart';
import 'package:parking_gird/shared/components/components.dart';

class RateUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Rate Us'),
      drawer: customDrawer(context),
      body: Center(
        child: Text('Rate Us Screen',style: TextStyle(
            color: Colors.white,
            fontSize: 40
        ),),
      ),
    );
  }
}
