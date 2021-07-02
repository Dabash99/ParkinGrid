// To parse this JSON data, do
//
//     final getAllParks = getAllParksFromJson(jsonString);

import 'dart:convert';

GetAllParks getAllParksFromJson(String str) => GetAllParks.fromJson(json.decode(str));

String getAllParksToJson(GetAllParks data) => json.encode(data.toJson());

class GetAllParks {
  GetAllParks({
    this.id,
    this.cityName,
    this.garageName,
    this.parkings,
    this.v,
  });

  String id;
  String cityName;
  String garageName;
  List<Parking> parkings;
  int v;

  factory GetAllParks.fromJson(Map<String, dynamic> json) => GetAllParks(
    id: json["_id"],
    cityName: json["cityName"],
    garageName: json["garageName"],
    parkings: List<Parking>.from(json["parkings"].map((x) => Parking.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "cityName": cityName,
    "garageName": garageName,
    "parkings": List<dynamic>.from(parkings.map((x) => x.toJson())),
    "__v": v,
  };
}

class Parking {
  Parking({
    this.userData,
    this.id,
    this.parkingFloor,
    this.parkingName,
    this.status,
    this.Mode,
  });

  UserData userData;
  String id;
  String parkingFloor;
  String parkingName;
  String status;
  String Mode;
  bool selected =false;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
    userData: UserData.fromJson(json["userData"]),
    id: json["_id"],
    parkingFloor: json["parking_Floor"],
    parkingName: json["parking_Name"],
    status: json["status"],
    Mode: json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData.toJson(),
    "_id": id,
    "parking_Floor": parkingFloor,
    "parking_Name": parkingName,
    "status": status,
    "mode": Mode,
  };
}

class UserData {
  UserData({
    this.carNumber,
    this.carLetter,
    this.email,
    this.phoneNumber,
  });

  List<String> carNumber;
  List<String> carLetter;
  String email;
  String phoneNumber;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    carNumber: json["carNumber"] == null ? null : List<String>.from(json["carNumber"].map((x) => x)),
    carLetter: json["carLetter"] == null ? null : List<String>.from(json["carLetter"].map((x) => x)),
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "carNumber": carNumber == null ? null : List<dynamic>.from(carNumber.map((x) => x)),
    "carLetter": carLetter == null ? null : List<dynamic>.from(carLetter.map((x) => x)),
    "email": email == null ? null : email,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
  };
}
