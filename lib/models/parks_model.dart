class GetAllParks {
  String sId;
  String cityName;
  String garageName;
  List<Parkings> parkings;

  GetAllParks({this.sId, this.cityName, this.garageName, this.parkings,});

  GetAllParks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cityName = json['cityName'];
    garageName = json['garageName'];
    if (json['parkings'] != null) {
      parkings = new List<Parkings>();
      json['parkings'].forEach((v) {
        parkings.add(new Parkings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cityName'] = this.cityName;
    data['garageName'] = this.garageName;
    if (this.parkings != null) {
      data['parkings'] = this.parkings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parkings {
  UserData userData;
  String sId;
  String parkingFloor;
  String parkingName;
  String status;
  String Mode;

  bool selected =false;

  Parkings(
      {this.userData,
        this.sId,
        this.parkingFloor,
        this.parkingName,
        this.status});

  Parkings.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
    sId = json['_id'];
    parkingFloor = json['parking_Floor'];
    parkingName = json['parking_Name'];
    status = json['status'];
    Mode =json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    data['_id'] = this.sId;
    data['parking_Floor'] = this.parkingFloor;
    data['parking_Name'] = this.parkingName;
    data['status'] = this.status;
    return data;
  }
}

class UserData {
  String email;
  String phoneNumber;
  int carNumber;
  String carLetter;

  UserData({this.email, this.phoneNumber, this.carNumber, this.carLetter});

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    carNumber = json['carNumber'];
    carLetter = json['carLetter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['carNumber'] = this.carNumber;
    data['carLetter'] = this.carLetter;
    return data;
  }
}
