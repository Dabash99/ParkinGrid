
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
  @required String email,
  @required String password
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' :email,
      'password':password
    }).then((value){
      loginModel= LoginModel.fromJson(value.data);
      print('Login Model Data === ${loginModel.token}');
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print('Error : ${error.toString()}');
      emit(LoginErrorState(error.toString()));

    });
  }
  IconData suffix =Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;

    suffix = isPasswordShown
        ? Icons.visibility
        : Icons.visibility_off;
    emit(LoginChangeVisibilityState());
  }
}
