part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class LoadingUserDataState extends AppState {}

class SuccessUserDataState extends AppState
{
  final LoginModel loginModel;

  SuccessUserDataState(this.loginModel);
}
class ErrorUserDataState extends AppState {}


