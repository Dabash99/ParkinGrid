import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_gird/layout/cubit/app_cubit.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  Position currentpostion;
  final Completer<GoogleMapController> _controllerGoogle = Completer();
  static final CameraPosition _keyplex =
      CameraPosition(target: LatLng(30.287265, 31.7406), zoom: 30.0);

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
  String id;
  String name = 'Garage Name';

  //Direction API فيزا يا حيوان

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
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
                            compassEnabled: false,
                            padding: EdgeInsets.only(bottom: 0),
                            myLocationButtonEnabled: false,
                            initialCameraPosition: _keyplex,
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: true,
                            markers: markers.values.toSet(),
                            onMapCreated: (GoogleMapController controller) {
                              _controllerGoogle.complete(controller);
                              mapController = controller;
                              locatepostion();
                              setState(() {
                                for (int index = 0;
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
                                  );
                                  markers[garageCubit.getAllGarages
                                      .garages[index].garageName] = marker;
                                  print('Markers : ${marker}');
                                  print(
                                      'LSskjga : ${garageCubit.getAllGarages.garages[0].garageName}');
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
                                  // inkwell color
                                  child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.my_location,
                                        color: Colors.white),
                                  ),
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
                                    // inkwell color
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      mapController.animateCamera(
                                        CameraUpdate.zoomIn(),
                                      );
                                    },
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
                                    // inkwell color
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      mapController.animateCamera(
                                        CameraUpdate.zoomOut(),
                                      );
                                    },
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
                                      onPressed: () {
                                        garageCubit.getBestDistance(
                                            currentpostion: currentpostion);
                                        setState(() {
                                          distance = garageCubit.distance;
                                          name = Ganame;
                                          id = garageCubit.nearestGarageID;
                                        });
                                      },
                                      label: Text(
                                        'Get the Nearest Garage'.toUpperCase(),
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
                          '${name.toUpperCase()}', // Garage Name
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
                        ElevatedButton(
                            onPressed: () {
                              navigateTo(context, ParkingScreen());
                            },
                            child: Text('Book Now')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
