import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import 'package:parking_gird/shared/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/styles/colors.dart';
import 'package:parking_gird/util/cutom_dialog.dart';
import 'dart:async';

import 'package:parking_gird/util/disable.dart';
import 'package:parking_gird/util/get_the_distanceBetween_twopoints.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  Position currentpostion;
  final Completer<GoogleMapController> _controllerGoogle = Completer();
  static final CameraPosition _keyplex =
      CameraPosition(target: LatLng(0, 0), zoom: 15.0);

  // Method for retrieving the current location
  void locatepostion() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentpostion = position;
    var latlatposition = LatLng(position.latitude, position.longitude);
    var camera_Position = CameraPosition(target: latlatposition, zoom: 14);
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(camera_Position));
  }

  BitmapDescriptor customIcon;
  final Map<String, Marker> markers = {};

  bool textIGnoring({@required String text}) {
    if (text == 'Please Select a Garage') {
      return true;
    } else {
      return false;
    }
  }

  //Change Map Marker
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(15, 15)),
            'assets/images/mapMarker.png')
        .then((icon) {
      customIcon = icon;
    });
    super.initState();
  }

  double distance = 0.0;
  var cc = GlobalKey();

  // Object for PolylinePoints
  PolylinePoints polylinePoints;
  var lat, lng;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  dynamic PolylinesResult;

// Map storing polylines created by connecting
// two points
  Map<PolylineId, Polyline> polylines = {};
  var polyline;

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

  var g = 'Please Select a Garage';
  String id;
  String name = 'Garage Name';
  double opacityLevel = 0.0;
  bool showhide = true;

  double totalDistance({
    @required dynamic polylineCoordinates,
  }) {
    double TotalDistance = 0.0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      TotalDistance += coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    return TotalDistance;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var garageCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: customAppBar(title: 'Home Screen'),
          drawer: customDrawer(context),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: double.infinity,
                    height: 420,
                    child: Stack(
                      children: [
                        ConditionalBuilder(
                          condition: state is! LoadingAllGaragesDataState,
                          builder: (context) => GoogleMap(
                            compassEnabled: true,
                            myLocationButtonEnabled: false,
                            initialCameraPosition: _keyplex,
                            mapType: MapType.hybrid,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: true,
                            markers: markers.values.toSet(),
                            polylines: Set<Polyline>.of(polylines.values),
                            onMapCreated: (GoogleMapController controller) {
                              _controllerGoogle.complete(controller);
                              mapController = controller;
                              locatepostion();
                              setState(() {
                                for (var index = 0;
                                    index <
                                        garageCubit
                                            .getAllGarages.garages.length;
                                    index++) {
                                  final marker = Marker(
                                      markerId: MarkerId(garageCubit
                                          .getAllGarages
                                          .garages[index]
                                          .garageName),
                                      icon: customIcon,
                                      position: LatLng(
                                          garageCubit.getAllGarages
                                              .garages[index].lat,
                                          garageCubit.getAllGarages
                                              .garages[index].long),
                                      infoWindow: InfoWindow(
                                        title: garageCubit.getAllGarages
                                            .garages[index].garageName,
                                        snippet: garageCubit.getAllGarages
                                            .garages[index].cityName,
                                      ),
                                      onTap: () async {
                                        dynamic _placeDistance;
                                        await _createPolylines(
                                            destination: Position(
                                                longitude: garageCubit
                                                    .getAllGarages
                                                    .garages[index]
                                                    .long,
                                                latitude: garageCubit
                                                    .getAllGarages
                                                    .garages[index]
                                                    .lat));
                                        _placeDistance = totalDistance(
                                            polylineCoordinates:
                                                polylineCoordinates);
                                        _placeDistance = double.parse(
                                            (_placeDistance)
                                                .toStringAsFixed(2));
                                        print(
                                            'Distance === ${_placeDistance}');
                                        //d = totalDistance(polylineCoordinates: coordintae);
                                        setState(() {
                                          g = garageCubit.getAllGarages
                                              .garages[index].garageName;
                                          distance = _placeDistance;
                                          showhide = false;
                                          polylineCoordinates = [];
                                        });
                                      });
                                  markers[garageCubit.getAllGarages
                                      .garages[index].garageName] = marker;
                                  print('Markers : $marker');
                                }
                              });
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipOval(
                              child: Material(
                                color: Color(0xff078547).withOpacity(0.9),
                                // button color
                                child: InkWell(
                                  splashColor: Colors.green[100],
                                  onTap: () {
                                    mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            currentpostion.latitude,
                                            currentpostion.longitude,
                                          ),
                                          zoom: 18.0,
                                        ),
                                      ),
                                    );
                                  },
                                  // inkwell color
                                  child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.my_location,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Show zoom buttons
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: Color(0xff078547).withOpacity(0.9),
                                  // button color
                                  child: InkWell(
                                    splashColor: Colors.green[100],
                                    onTap: () {
                                      mapController.animateCamera(
                                        CameraUpdate.zoomIn(),
                                      );
                                    },
                                    // inkwell color
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ClipOval(
                                child: Material(
                                  color: Color(0xff078547).withOpacity(0.9),
                                  // button color
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () {
                                      mapController.animateCamera(
                                        CameraUpdate.zoomOut(),
                                      );
                                    },
                                    // inkwell color
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ConditionalBuilder(
                                condition:
                                    state is! LoadingNearestGarageDataState,
                                builder: (context) =>
                                    FloatingActionButton.extended(
                                  onPressed: () async {
                                    garageCubit.getBestDistance(
                                        currentpostion: currentpostion);
                                    setState(() {
                                      g = Ganame;
                                      lat = garageCubit.nearestLat;
                                      lng = garageCubit.nearestLng;
                                      id = garageCubit.nearestGarageID;
                                      mapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(
                                              garageCubit.nearestLat,
                                              garageCubit.nearestLng,
                                            ),
                                            zoom: 15.0,
                                          ),
                                        ),
                                      );
                                    });
                                    showhide = !showhide;
                                    print(
                                        'Position ==== ${Position(longitude: lng, latitude: lat)}');
                                    if (!showhide) {
                                      await _createPolylines(
                                          destination: Position(
                                              longitude:
                                                  garageCubit.nearestLng,
                                              latitude:
                                                  garageCubit.nearestLat));
                                      var d = totalDistance(
                                          polylineCoordinates:
                                              polylineCoordinates);
                                      var _placeDistance = double.parse(
                                          (d).toStringAsFixed(2));
                                      setState(() {
                                        distance = _placeDistance;
                                      });
                                      print(
                                          '33333333333444---- $polylineCoordinates');
                                    } else {
                                      polylineCoordinates = [];
                                      await _createPolylines(
                                          destination: Position(
                                              longitude: null,
                                              latitude: null));
                                    }

                                    print('EEWE ======== $distance');
                                    print(
                                        'eeeeee============ ${DiableinMAP(DISTANCE: distance)}');

                                    if (!DiableinMAP(DISTANCE: distance)) {
                                      showToastt(
                                        //TODO
                                          msg: 'ssssss',
                                          state: ToastStates.WARNING);
                                    }
                                  },
                                  label: Text(
                                    'show the Nearest Garage'.toUpperCase(),
                                  ),
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/images/logo_splash.png'),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        spreadRadius: 2,
                        offset: Offset(2, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${g.toUpperCase()}',
                        key: cc,
                        // Garage Name
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Distance to garage : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${distance} Km',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff078547)),
                          ),
                        ],
                      ),
                      IgnorePointer(
                        ignoring: textIGnoring(text: g),
                        child: ElevatedButton(
                            onPressed: () {
                              if (distance < 2) {
                                //+++++++++++++++++++++++++++++++
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                          title:
                                              'Please Select the Duration of Reservation',
                                          descriptions: g,
                                          text: 'Go to select your park',
                                          distanc: distance);
                                    });
                                //+++++++++++++++++++++++++++++++

                              } else {
                                navigateTo(
                                    context,
                                    ParkingScreen(
                                      garage: g,
                                      distance: distance,
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: !textIGnoring(text: g)
                                    ? Color(0xff078547)
                                    : defaultColor.withOpacity(0.5),
                                elevation: 0),
                            child: Text('Open Garage ')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
