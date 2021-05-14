import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  LoginModel loginModel;

  void userReister({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required String phone,
    @required String carLetter,
    @required String carNumber,
    })
  {
    emit(RegisterLoadingState());
    
    DioHelper.postData(url: REGISTER, data: {

      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'password':password,
      'carNumber':carNumber,
      'carLetter':carLetter,
      'phoneNumber':phone
    }).then((value){
      print(value.data);
      loginModel =LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print('Error :${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off ;

    emit(RegisterChangePasswordVisibilityState());
  }
}
