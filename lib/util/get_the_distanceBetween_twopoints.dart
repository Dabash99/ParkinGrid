import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/cupertino.dart';

//Method that get the distance
/*double totalDistance({
  @required dynamic polylineCoordinates,
}) {
  double TotalDistance;
  for (var i = 0; i < polylineCoordinates.length - 1; i++) {
    TotalDistance += coordinateDistance(
      polylineCoordinates[i].latitude,
      polylineCoordinates[i].longitude,
      polylineCoordinates[i + 1].latitude,
      polylineCoordinates[i + 1].longitude,
    );
  }
  return TotalDistance;
}*/
double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  var d = 12742 * asin(sqrt(a));
  return d;
}

