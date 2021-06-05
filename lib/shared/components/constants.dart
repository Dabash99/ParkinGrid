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


String token ;
String googleMapAPI ='AIzaSyBzAkqmEqPw2S98nAA6oG31iqu_L6mw4n0';
String Ganame = CacheHelper.getData(key: 'Garage Name');

bool isSelected =false;
