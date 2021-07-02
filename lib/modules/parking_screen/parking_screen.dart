import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/home_screen/home_screen.dart';
import 'package:parking_gird/modules/timer_screen/timer_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:parking_gird/util/Mode.dart';
import 'package:parking_gird/util/choose_color.dart';
import 'package:parking_gird/util/disable.dart';

class ParkingScreen extends StatefulWidget {
  @override
  dynamic garage,distance,lat ,lng;
  String mode;
  _ParkingScreenState createState() => _ParkingScreenState();
  ParkingScreen({Key key,@required this.garage,@required this.distance,this.mode,@required this.lat,@required this.lng}):super(key: key);
}

bool IGNORING({@required String color}) {
  if (color == 'yellow' || color == 'red') {
    return true;
  } else {
    return false;
  }
}
String buttonText='';


var parkId;
var pName;
var fName;

String TextButtonString({@required double Dist}){
  if(Dist<2){buttonText = 'Book Now';}
  else{buttonText = 'Back';}
}
class _ParkingScreenState extends State<ParkingScreen> {
  @override
  void initState(){
    super.initState();
    TextButtonString(Dist: widget.distance);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getGarageParks(GaName:  widget.garage,mode: widget.mode),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          print('PArking Mode === ${widget.mode}');
          CacheHelper.saveData(key: 'garageName', value: widget.garage);
          CacheHelper.saveData(key: 'distance', value: widget.distance);
          CacheHelper.saveData(key: 'mode', value: widget.mode);

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
                                    Mode: Mode(mode: idGarage.getAllParks.parkings[index].Mode),
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
                                                .parkings[index].id;
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
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Disabled(PARKID: parkId)
                                          ? Color(0xff078547)
                                          : defaultColor.withOpacity(0.5),
                                    elevation: 0
                                  ),
                                  onPressed: () {
                                    if(DiableinMAP(DISTANCE: widget.distance)){
                                      print('TRUE');
                                      if (Disabled(PARKID: parkId)) {
                                        print('TRUE2');

                                        idGarage.sendParkRequest(
                                            garageName: Ganame,
                                            id: parkId,
                                            status: 1);
                                        navigateAndFinish(
                                            context,
                                            TimerScreen(
                                              mode:widget.mode,
                                              garageName: widget.garage,
                                              parkingname: pName,
                                              parkingfloor: fName,
                                              id: parkId,
                                              lng: widget.lng,
                                              lat: widget.lat,
                                              distance: widget.distance,
                                            ));
                                      } else {
                                        print('False2');
                                        showToastt(
                                            msg: 'Please Select Park',
                                            state: ToastStates.WARNING);
                                      }
                                    }else{
                                      print('False');
                                      navigateAndFinish(context, HomeScreen());
                                    }
                                  },
                                  child: Text('$buttonText')),
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
                                      string: 'Parked', color: Colors.red),
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
