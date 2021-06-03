import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/styles/colors.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.menu,
                        color: defaultColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                      child: Text(
                    'Help',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How to Use our App',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tristique sapien nec sem condimentum pellentesque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nunc convallis dolor et neque fermentum pretium. Nulla facilisi. Vestibulum at molestie sem. Proin suscipit magna at fringilla dapibus. Vestibulum mi lorem, tincidunt at tempus sed, fringilla eu elit.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Align(alignment: Alignment.bottomRight,
                  child: Image.asset('assets/images/I.png')),

            ],
          ),
        ),
      ),
    );
  }
}
