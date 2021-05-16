import 'package:flutter/material.dart';
import 'package:parking_gird/shared/components/components.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Help'),
      drawer: customDrawer(context),
      body: Center(
        child: Text('Help Screen',style: TextStyle(
          color: Colors.white,
          fontSize: 40
        ),),
      ),
    );
  }
}
