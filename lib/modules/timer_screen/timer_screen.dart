import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_gird/layout/cubit/app_cubit.dart';

import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/modules/timer_screen/cubit/address_cubit.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:parking_gird/util/LocatePosition.dart';
import 'package:parking_gird/util/disable.dart';

class TimerScreen extends StatefulWidget {
  dynamic parkingname;
  dynamic parkingfloor;
  dynamic id;
  dynamic garageName;
  dynamic distance;
  dynamic mode;
  dynamic lat;
  dynamic lng;

  TimerScreen(
      {Key key,
      @required this.parkingfloor,
      @required this.parkingname,
      @required this.id,
      @required this.garageName,
      @required this.distance,
      @required this.mode,
      @required this.lng,
      @required this.lat})
      : super(key: key);

  static final CameraPosition _keyplex =
  CameraPosition(target: LatLng(0, 0), zoom: 15.0);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final Completer<GoogleMapController> _controllerGoogle = Completer();

  GoogleMapController mapController;

  void locatepostion() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentpostion = position;
    var latlatposition = LatLng(position.latitude, position.longitude);
    var camera_Position = CameraPosition(target: latlatposition, zoom: 14);
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(camera_Position));
  }

  PolylinePoints polylinePoints;

  dynamic PolylinesResult;

  var polyline;

  List<LatLng> polylineCoordinates = [];

  Map<PolylineId, Polyline> polylines = {};

  final Map<String, Marker> markers = {};

  BitmapDescriptor customIcon;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(15, 15)),
        'assets/images/mapMarker.png')
        .then((icon) {
      customIcon = icon;
    });
     _createPolylines(destination: Position(longitude: widget.lng,latitude:widget.lat ));

    super.initState();
  }

  Future<dynamic> _createPolylines({@required Position destination}) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyBzAkqmEqPw2S98nAA6oG31iqu_L6mw4n0', // Google Maps API Key
      PointLatLng(currentpostion.latitude, currentpostion.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    )
        .then((value) {
      PolylinesResult = value.points;
    });

    // Adding the coordinates to the list
    print('result ========== ${PolylinesResult}');
    if (PolylinesResult.isNotEmpty) {
      PolylinesResult.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    // Defining an ID
    var id = PolylineId('poly');
    // Initializing Polyline
    polyline = Polyline(
      polylineId: id,
      color: defaultColor,
      points: polylineCoordinates,
      width: 4,
    );
    // Adding the polyline to the map
    polylines[id] = polyline;
    print('ssssss ======== $polylineCoordinates');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            drawer: customDrawer(context),
            appBar: customAppBar(title: 'Timer'),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Garage Name : $Ganame',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Park Floor : ${widget.parkingfloor}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Park Name : ${widget.parkingname}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 420,
                      child: ConditionalBuilder(
                        condition: PolylinesResult != null,
                        builder:(context)=>GoogleMap (
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: TimerScreen._keyplex,
                          myLocationEnabled: true,
                          zoomControlsEnabled: true,
                          markers: markers.values.toSet(),
                          onMapCreated: (GoogleMapController controller) async {
                            _controllerGoogle.complete(controller);
                            mapController = controller;
                            locatepostion();
                          },
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                      ),
                    ),
                  ),
                ),
                /*Center(
                    child: CircularCountDownTimer(
                      duration: 6000,
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
                          fontSize: 40.0,
                          color: defaultColor,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      autoStart: true,
                      onComplete: () {
                        HomeCubit.get(context).sendParkRequest(
                            garageName: Ganame, id: id, status: 3);
                        AppCubit.get(context).removeParkData();
                        showDialog(
                            context: context,
                            builder: alertDialogTimer,
                            barrierDismissible: false);
                      },
                    )),*/
               // Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      HomeCubit.get(context)
                          .sendParkRequest(garageName: Ganame, id: widget.id, status: 3);
                      AppCubit.get(context).removeParkData();
                      isSelected = false;
                      parkId = null;
                      Disabled(PARKID: parkId);
                      navigateAndFinish(
                          context,
                          ParkingScreen(
                            mode: widget.mode,
                            garage: widget.garageName,
                            distance: widget.distance,
                          ));
                    },
                    child: Text(
                      'Cancel Booking',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
