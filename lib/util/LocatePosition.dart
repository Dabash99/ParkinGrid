import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMapController mapController;
Position currentpostion;

void locatepostion() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentpostion = position;
  var latlatposition = LatLng(position.latitude, position.longitude);
  var camera_Position = CameraPosition(target: latlatposition, zoom: 14);
  await mapController
      .animateCamera(CameraUpdate.newCameraPosition(camera_Position));
}