import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/modules/login/login_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;
  void getUserData() {
    emit(LoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      printFullText(loginModel.data.firstName);
      emit(SuccessUserDataState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserDataState());
    });
  }

}
