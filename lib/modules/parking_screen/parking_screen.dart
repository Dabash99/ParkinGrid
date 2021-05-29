import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/timer_screen/timer_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:parking_gird/util/choose_color.dart';
import 'package:parking_gird/util/disable.dart';

class ParkingScreen extends StatefulWidget {
  @override
  var garage;
  _ParkingScreenState createState() => _ParkingScreenState();
  ParkingScreen({Key key,@required this.garage}):super(key: key);
}

bool IGNORING({@required String color}) {
  if (color == 'yellow' || color == 'red') {
    return true;
  } else {
    return false;
  }
}


var parkId;
var pName;
var fName;

/*bool TEXTIGNORING({@required String id}){
  if( id.isNotEmpty){
    return false;
  }
  else {
    return true;
  }
}*/

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getGarageParks(GaName:  widget.garage),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var idGarage = HomeCubit.get(context);
          return Scaffold(
            drawer: customDrawer(context),
            appBar: customAppBar(title: 'Parks Screen'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: state is SuccessAllParksDataState,
                    builder: (context) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                widget.garage,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                children: List.generate(
                                    idGarage.getAllParks.parkings.length,
                                    (index) {
                                  return buildParks(
                                    Ignoring: IGNORING(
                                        color: idGarage.getAllParks
                                            .parkings[index].status),
                                    name: idGarage.getAllParks.parkings[index]
                                        .parkingName,
                                    color: ChooseColor(
                                        status: idGarage.getAllParks
                                            .parkings[index].status),
                                    ontapFunction: () {
                                      setState(() {
                                        for (var i = 0;
                                            i <
                                                idGarage.getAllParks.parkings
                                                    .length;
                                            i++) {
                                          if (i == index) {
                                            //Reverse Selected State
                                            idGarage.getAllParks.parkings[index]
                                                    .selected =
                                                !idGarage.getAllParks
                                                    .parkings[index].selected;
                                            parkId = idGarage.getAllParks
                                                .parkings[index].sId;
                                            pName = idGarage.getAllParks
                                                .parkings[index].parkingName;
                                            fName = idGarage.getAllParks
                                                .parkings[index].parkingFloor;
                                            print('Selected ID = $parkId');
                                          } else {
                                            idGarage.getAllParks.parkings[i]
                                                .selected = false;
                                          }
                                          if(idGarage.getAllParks.parkings[index].selected == false){
                                            parkId = null;
                                          }
                                        }
                                      });
                                    },
                                    Width: idGarage.getAllParks.parkings[index]
                                            .selected
                                        ? 8
                                        : 0,
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              IgnorePointer(
                                ignoring: !Disabled(PARKID: parkId),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Disabled(PARKID: parkId)
                                            ? Color(0xff078547)
                                            : defaultColor.withOpacity(0.5),
                                      elevation: 0
                                    ),
                                    onPressed: () {
                                      if (Disabled(PARKID: parkId)) {
                                        idGarage.sendParkRequest(
                                            garageName: Ganame,
                                            id: parkId,
                                            status: 1);
                                        navigateAndFinish(
                                            context,
                                            TimerScreen(
                                              parkingname: pName,
                                              parkingfloor: fName,
                                              id: parkId,
                                            ));
                                      } else {
                                        showToastt(
                                            msg: 'Please Select Park',
                                            state: ToastStates.WARNING);
                                      }
                                    },
                                    child: Text('Book Now')),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(child: myDivider()),
                                  Center(
                                    child: Text(
                                      'Hint',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: defaultColor.withOpacity(0.5)),
                                    ),
                                  ),
                                  Expanded(child: myDivider()),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildInfoPark(
                                      string: 'Reserved', color: Colors.red),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  buildInfoPark(
                                      string: 'Booked',
                                      color: Colors.orangeAccent),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  buildInfoPark(
                                      string: 'Free', color: Colors.green),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
