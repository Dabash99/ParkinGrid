part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class LoadingUserDataState extends AppState {}

class SuccessUserDataState extends AppState
{
  final UserLoginData loginModel;

  SuccessUserDataState(this.loginModel);
}
class ErrorUserDataState extends AppState {}



class LoadingUpdateUserDataState extends AppState {}

class SuccessUpdateUserDataState extends AppState
{
  final UserLoginData loginModel;

  SuccessUpdateUserDataState(this.loginModel);
}
class ErrorUpdateUserDataState extends AppState {}