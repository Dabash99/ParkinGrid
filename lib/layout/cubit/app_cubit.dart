import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_gird/models/login_model.dart';

import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  UserLoginData loginModel;
  void getUserData() {
    emit(LoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = UserLoginData.fromJson(value.data);
      printFullText('DAtaaaa ====== ${loginModel.firstName}');
      emit(SuccessUserDataState(loginModel));
    }).catchError((error) {
      print(error.toString());
      print('EEEEERRR ====== ${DioHelper.dio.options.headers}');
      emit(ErrorUserDataState());
    });
  }

  void updateUserData({
    @required String firstname,
    @required String lastname,
    @required String email,
    String password,
    @required String carnumber,
    @required String carLetter,
    @required String phoneNumber,
}){
    emit(LoadingUpdateUserDataState());
   if(password.isEmpty){
     DioHelper.postData(
         url: PROFILE,
         token: token,
         data: {
           'firstName':firstname,
           'lastName':lastname,
           'email':email,
           //'password': password,
           'carNumber': carnumber,
           'carLetter': carLetter,
           'phoneNumber': phoneNumber,
         }
     ).then((value) {
       loginModel = UserLoginData.fromJson(value.data);
       printFullText('DAtaaaa ====== ${value.data}');
       emit(SuccessUpdateUserDataState(loginModel));
     }).catchError((error) {
       print(error.toString());
       print('EEEEERRR ====== ${DioHelper.dio.options.headers}');
       emit(ErrorUpdateUserDataState());
     });
   }
   else{
     DioHelper.postData(
         url: PROFILE,
         token: token,
         data: {
           'firstName':firstname,
           'lastName':lastname,
           'email':email,
           'password': password,
           'carNumber': carnumber,
           'carLetter': carLetter,
           'phoneNumber': phoneNumber,
         }
     ).then((value) {
       loginModel = UserLoginData.fromJson(value.data);
       printFullText('DAtaaaa ====== ${value.data}');
       emit(SuccessUpdateUserDataState(loginModel));
     }).catchError((error) {
       print(error.toString());
       print('EEEEERRR ====== ${DioHelper.dio.options.headers}');
       emit(ErrorUpdateUserDataState());
     });
   }
  }

  void removeParkData(){
    CacheHelper.removeData(key: 'Parking Name');
    CacheHelper.removeData(key: 'Parking Floor');
    CacheHelper.removeData(key: 'ID');
     /*parkname = CacheHelper.getData(key: 'Parking Name');
     parkfloor =CacheHelper.getData(key: 'Parking Floor');
     id= CacheHelper.getData(key: 'ID');*/
  }
}