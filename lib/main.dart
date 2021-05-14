import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_gird/layout/cubit/app_cubit.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/modules/home_screen/home_screen.dart';
import 'package:parking_gird/modules/splash_screen.dart';
import 'package:parking_gird/shared/bloc_observer.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/network/remote/dio_helper.dart';
import 'package:parking_gird/shared/styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  Widget widget;
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  if (token != null) {
    widget = HomeScreen();
  } else {
    widget = SplashScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeCubit()..getGarages()),
        BlocProvider(create: (context) => AppCubit()..getUserData(),),

      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: Colors.green,
            title: 'Parking Grid',
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}