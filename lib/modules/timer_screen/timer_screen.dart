import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/styles/colors.dart';

int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600;

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        drawer: customDrawer(context),
        appBar: customAppBar(title: 'Timer'),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Garage Name : $Ganame',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          Text('Park Floor : $parkfloor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(width: 15,),
                          Text('Park Name : $parkname',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularCountDownTimer(
                    duration:60,
                    initialDuration: 0,
                    controller: CountDownController(),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    ringColor: Colors.grey[300],
                    ringGradient: null,
                    fillColor: Colors.green[400],
                    fillGradient: null,
                    backgroundColor: Colors.white,
                    backgroundGradient: null,
                    strokeWidth: 20.0,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                        fontSize: 40.0, color: defaultColor, fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.MM_SS,
                    isReverse: true,
                    isReverseAnimation: true,
                    isTimerTextShown: true,
                    autoStart: true,
                    onComplete:(){
                      HomeCubit.get(context).sendParkRequest(garageName: Ganame, id: id, status: 3);
                      showDialog(context: context, builder: alertDialogTimer,
                          barrierDismissible: false);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

/*
* CountdownTimer(
              endTime: endTime,
              endWidget: AlertDialog(
                title: Row(
                  children: [
                    Icon( Icons.warning,color: Colors.orangeAccent,),
                    SizedBox(width: 8,),
                    Text('Attention',style: TextStyle(color:Colors.orange),),
                  ],
                ),
                content: Text('Your Booking is Cancelled'),
                actions: [
                  TextButton(
                    onPressed: () {
                      navigateAndFinish(context, ParkingScreen());
                    },
                    child: Text('OK, Back to book other park',style: TextStyle(color:defaultColor)),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateAndFinish(context, HomeScreen());
                    },
                    child: Text('Cancel',style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),

        )*/
