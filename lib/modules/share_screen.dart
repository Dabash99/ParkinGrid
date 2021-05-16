import 'package:flutter/material.dart';
import 'package:parking_gird/shared/components/components.dart';

class ShareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Share'),
      drawer: customDrawer(context),
      body: Center(
        child: Text('Share Screen',style: TextStyle(
            color: Colors.white,
            fontSize: 40
        ),),
      ),
    );
  }
}
