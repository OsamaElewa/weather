import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp2/modules/home_screen.dart';
import 'package:weatherapp2/modules/test.dart';
import 'package:weatherapp2/shared/bloc_observer.dart';
import 'package:weatherapp2/shared/cubit/cubit.dart';
import 'package:weatherapp2/shared/network/remote/dio_helper.dart';
import 'package:weatherapp2/shared/network/remote/weather_services/weather_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>WeatherCubit()..getCurrentWeatherDate(cityName: 'cairo')..getTopFiveCities()..getPreviosWeatherDate(cityName: 'cairo'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}