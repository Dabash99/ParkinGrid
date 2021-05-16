import 'package:parking_gird/modules/login/login_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/network/end_points.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';


void signOut(context){
  DioHelper.postData(url:LOGOUT,token: token).then((value) {
    showToastt(msg: 'Logout Successfully', state: ToastStates.SUCCESS);
  }).catchError((onError){
    printFullText('eqwkkvv ==== ${DioHelper.dio.options.headers}');
    printFullText('TOKEN ==== ${token}');
    print('@@@@@@@ =========== ${onError.toString()}');
  });
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}


void printFullText(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) { print(match.group(0));});
}


String token ='';
String googleMapAPI ='AIzaSyC28mzOn8puR988_9M8SUx8_1msrWxjmWU';
String Ganame = CacheHelper.getData(key: 'Garage Name');
String parkname = CacheHelper.getData(key: 'Parking Name');
String parkfloor =CacheHelper.getData(key: 'Parking Floor');
String id= CacheHelper.getData(key: 'ID');
bool isSelected =false;
