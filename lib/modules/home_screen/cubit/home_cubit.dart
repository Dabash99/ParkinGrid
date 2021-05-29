import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:parking_gird/models/locations.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/models/parks_model.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';
import 'package:parking_gird/util/get_the_distanceBetween_twopoints.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
 /* LoginModel loginModel;

  void getUserData() {
    emit(LoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data.firstName);
      emit(SuccessUserDataState(loginModel));
    }).catchError((error) {
      print(error.toString());
      print('EEEEERRR ====== ${DioHelper.dio.options.headers}');
      emit(ErrorUserDataState());
    });
  }*/

  GetAllGarages getAllGarages;

  void getGarages() {
    emit(LoadingAllGaragesDataState());
    DioHelper.getData(url: GETALLGARAGE).then((value) {
      getAllGarages = GetAllGarages.fromJson(value.data);
      print('Garages : ${value.data}');
      emit(SuccessAllGaragesState(getAllGarages));
    }).catchError((error) {
      print('Erorr = ${error.toString()}');
      emit(ErrorAllGaragesState());
    });
  }
  Position currentpositon;
  double distance = 0.0;
  String name ;
  String nearestGarageID;
  var scope = {};

  var nearestLat;
  var nearestLng;
  void getBestDistance({@required Position currentpostion})  {
    emit(LoadingNearestGarageDataState());

    for (var index = 0; index < getAllGarages.garages.length; index++) {
      var d = coordinateDistance(
          getAllGarages.garages[index].lat,
          getAllGarages.garages[index].long,
          currentpostion.latitude,
          currentpostion.longitude);
      createPolylines(Position destination){

      };
      scope['${getAllGarages.garages[index].sId}'] = d;
      print('Scope = $scope');
    }
    final sorted = SplayTreeMap.from(
        scope, (key1, key2) => scope[key1].compareTo(scope[key2]));
    distance = sorted.values.first;
    //Nearest Garage Distance
    distance = double.parse((distance).toStringAsFixed(2));
    //Nearest Garage ID
    nearestGarageID = sorted.keys.first;
    //Nearest Garage Name
    getAllGarages.garages.forEach((element) {
      if (element.sId == nearestGarageID) {
        CacheHelper.saveData(key: 'Garage Name', value: element.garageName);
        nearestLat = element.lat;
        nearestLng = element.long;
      }
    }
    );
    emit(SuccessNearestGarageDataState(distance, nearestGarageID,nearestLat,nearestLng,scope));
  }

  GetAllParks getAllParks;

  void getGarageParks({@required String GaName}){
    emit(LoadingAllParksDataState());
    DioHelper.getData(url: GETPARKS,query:{
      'garagename': GaName
    }).then((value) {
      getAllParks=GetAllParks.fromJson(value.data);
      emit(SuccessAllParksDataState(getAllParks));
    }).catchError((error){
      print('ERRRROR=== ${error.toString()}');
      emit(ErrorAllParksDataState());
    });
  }

  bool selected = true;
  double width = 0;

  void sendParkRequest({@required String id,@required String garageName,@required int status}){
    emit(LoadingParkRequestBookState());
    DioHelper.postData(url: PARKREQUEST,query: {
      'garagename': garageName,
      'id' : id,
      'status': status,
    },token: token).then((value){
      getAllParks=GetAllParks.fromJson(value.data);
      emit(SuccessParkRequestBookState(getAllParks));
    }).catchError((onError){
      print('ERRRRRORRR ===== ${onError.toString()}');
      print('Token ====== $token');
      print('id ====== $id');
      print('garagename ====== $garageName');

      emit(ErrorParkRequestBookState());
    });
  }
}
