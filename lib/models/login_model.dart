class LoginModel{
  String token;
  bool status;
  UserLoginData data;
  String msg;
  LoginModel.fromJson(Map<String,dynamic>json){
    token =json['token'];
    msg =json['message'];
    status =json['status'];
    data =json['user'] != null ? UserLoginData.fromJson(json['user']) :null;
  }
}

class UserLoginData{
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  List<String> carNumber;
  List<String> carLetter;

  UserLoginData.fromJson(Map<String,dynamic>json){
    id = json['_id'];
    firstName =json['firstName'];
    lastName =json['lastName'];
    email = json['email'];
    phoneNumber =json['phoneNumber'];
    carNumber = json['carNumber'].cast<String>();
    carLetter = json['carLetter'].cast<String>();
  }
}