
class GetAllGarages {
  List<Garages> garages;

  GetAllGarages({this.garages});

  GetAllGarages.fromJson(Map<String, dynamic> json) {
    if (json['garages'] != null) {
      garages = new List<Garages>();
      json['garages'].forEach((v) {
        garages.add(new Garages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.garages != null) {
      data['garages'] = this.garages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Garages {
  String sId;
  String cityName;
  String garageName;
  double lat;
  double long;

  Garages({this.sId, this.cityName, this.garageName, this.lat, this.long});

  Garages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cityName = json['cityName'];
    garageName = json['garageName'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cityName'] = this.cityName;
    data['garageName'] = this.garageName;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
