part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}



class LoadingAllGaragesDataState extends HomeState {}

class SuccessAllGaragesState extends HomeState
{
  final GetAllGarages getAllGarages;

  SuccessAllGaragesState(this.getAllGarages);

}
class ErrorAllGaragesState extends HomeState {}



class LoadingNearestGarageDataState extends HomeState {}

class SuccessNearestGarageDataState extends HomeState
{

  final  dis, nearestGarageID ,nearestLat , nearestLng;

  SuccessNearestGarageDataState(this.dis, this.nearestGarageID, this.nearestLat,this.nearestLng);

}
class ErrorNearestGarageDataState extends HomeState {}



class LoadingAllParksDataState extends HomeState {}

class SuccessAllParksDataState extends HomeState
{
  GetAllParks getAllParks;

  SuccessAllParksDataState(this.getAllParks);

}
class ErrorAllParksDataState extends HomeState {}


class LoadingParkRequestBookState extends HomeState {}

class SuccessParkRequestBookState extends HomeState {
  GetAllParks getAllParks;

  SuccessParkRequestBookState(this.getAllParks);
}

class ErrorParkRequestBookState extends HomeState {}

