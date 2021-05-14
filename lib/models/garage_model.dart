class GarageModel{
  String id;
  String cityName;
  String garageName;
  double lat;
  double lng;
  //List parkings=[];

  GarageModel.formJson(Map <String ,dynamic>json){
    id = json['_id'];
    cityName = json['cityName'];
    garageName = json['garageName'];
    lat = json['lat'];
    lng = json['long'];
    /*json['parkings'].forEace((element){
      parkings.add(ParkingINGarage.fromJson(element));
    });*/
  }

}

/*class ParkingINGarage {
  String parkingID;
  String parkingFloor;
  String parkingName;
  ParkingData  data;

  ParkingINGarage.fromJson(Map <String,dynamic> json){
    parkingID =json['_id'];
    parkingFloor =json['parking_Floor'];
    parkingName =json ['parking_Name'];
    data = ParkingData.fromJson(json['data']);
  }
}

class ParkingData{
  String status;
  UserData userData;
  ParkingData.fromJson(Map<String , dynamic>json){
    status=json['status'];
    userData =UserData.fromJson(json['userData']) ;
  }
}

class UserData{
  String email;
  String phoneNumber;
  String carNumber;
  String carLetter;
  UserData.fromJson(Map<String, dynamic> json) {
     email=json['email'];
     phoneNumber= json['phoneNumber'];
     carNumber = json['carNumber'];
     carLetter =  json['carLetter'];
   }

}*/
