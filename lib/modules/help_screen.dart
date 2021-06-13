import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    void customLaunch(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print(' could not launch $command');
      }
    }
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer(context),
      body: SingleChildScrollView(
        child: SafeArea(
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
                        Text('About',style: TextStyle(fontSize: 25),),
                        Text('At first this app is for the garages that use our smart system and will not work on any other garage.',
                          style: TextStyle(fontSize: 15),),
                        Text('This version of the app is a trial version and we apologize to our customers for any problems you may face, and we are now working hard to improve and develop this application for the smart garage system.',
                          style: TextStyle(fontSize: 15),),
                        myDivider(),
                        Text(
                          'How to Use our App',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          'First you should download the app from your store ,After that you must create an account for you in our app ,You can create your account using your email, car number and personal number very easily ,After creating the account you can now use our app and watch the garages close to you .If you\'re close to the garage, it\'ll be easy to book a place for your car, and if you\'re away from the garage, you\'ll just see the empty places and you won\'t be able to book until you\'re close enough to the garage',
                          style: TextStyle(fontSize: 15),
                        ),
                        myDivider(),
                        Text('Contact Us',style: TextStyle(fontSize: 25),),
                       Column(
                         children: [
                           ElevatedButton(
                               onPressed: (){
                                 customLaunch(
                                     'mailto:ahmeddabash301@gmail.com?subject=Parking%20Grid');
                               },
                           child: Text('Ahmed Dabash'),),
                            ElevatedButton(
                              onPressed: (){
                                customLaunch(
                                    'mailto:mena.maged949@gmail.com?subject=Parking%20Grid');
                              },
                              child: Text('Mina Maged'),),
                            ElevatedButton(
                              onPressed: (){
                                customLaunch(
                                    'mailto:omarmohamed@gmail.com?subject=Parking%20Grid');
                              },
                              child: Text('Omar Mohamed'),),
                         ],
                       )
                      ],
                    ),
                  ),
                ),
               /* Align(alignment: Alignment.bottomRight,
                    child: Image.asset('assets/images/I.png')),*/

              ],
            ),
          ),
        ),
      ),
    );
  }
}
