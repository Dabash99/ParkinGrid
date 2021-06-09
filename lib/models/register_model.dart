class RegisterModel{
  String token;
  bool status;
  UserRegisterData data;
  String msg;
  RegisterModel.fromJson(Map<String,dynamic>json){
    token =json['token'];
    msg =json['message'];
    status =json['status'];
    data =json['user'] != null ? UserRegisterData.fromJson(json['user']) :null;
  }
}

class UserRegisterData{
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String carNumber;
  String carLetter;

  UserRegisterData.fromJson(Map<String,dynamic>json){
    id = json['_id'];
    firstName =json['firstName'];
    lastName =json['lastName'];
    email = json['email'];
    phoneNumber =json['phoneNumber'];
    carNumber=json['carNumber'];
    carLetter=json['carLetter'];
  }
}