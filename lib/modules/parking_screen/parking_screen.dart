import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/timer_screen/timer_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:parking_gird/util/choose_color.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}



bool IGNORING({@required String color}) {
  if (color == 'yellow' || color == 'red') {
    return true;
  } else {
    return false;
  }
}


class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getGarageParks(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
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
                                Ganame,
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
                                        print('22222 === $index');
                                        for (var i = 0;
                                            i < idGarage.getAllParks.parkings.length;
                                            i++) {
                                          if (i == index) {
                                            idGarage.getAllParks.parkings[index]
                                                    .selected =
                                                !idGarage.getAllParks
                                                    .parkings[index].selected;
                                            id=  idGarage.getAllParks
                                                .parkings[index].sId;
                                            parkname = idGarage.getAllParks.parkings[index].parkingName;
                                            parkfloor = idGarage.getAllParks.parkings[index].parkingFloor;

                                          } else {
                                            idGarage.getAllParks.parkings[i]
                                                .selected = true;
                                          }
                                        }
                                        print('### = $id');
                                      });
                                    },
                                    Width: idGarage.getAllParks.parkings[index].selected ? 0 : 8,
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    idGarage.sendParkRequest(garageName: Ganame, id: id, status: 1);
                                    navigateAndFinish(context, TimerScreen());
                                  }, child: Text('Book Now')),
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
