import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp2/models/previos_weather_model.dart';
import 'package:weatherapp2/shared/cubit/states.dart';
import 'package:weatherapp2/shared/network/remote/dio_helper.dart';
import 'package:weatherapp2/shared/network/remote/weather_services/weather_service.dart';

import '../../models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);

  CurrentWeather? currentWeather;

  void getCurrentWeatherDate({required String cityName}) {
    emit(WeatherLoadingState());
    DioHelper.getData(
      url: 'weather',
      query: {
        'q': cityName,
        'appid': 'b8310f3831b84652df63321591dabec2',
      },
    ).then((value) {
      currentWeather = CurrentWeather.fromJson(value.data);
      print(currentWeather!.name);
      print(currentWeather!.weather![0].icon);
      emit(WeatherSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WeatherErrorState());
    });
  }
  CurrentWeather? currentFiveWeather;
  List<CurrentWeather>fiveCitiesList=[];
  void getTopFiveCities() {
    emit(TopFiveLoadingState());
    List<String> cities=['london','moscow','paris','new york','tokyo'];
    cities.forEach((element) {
      DioHelper.getData(
        url: 'weather',
        query: {
          'q': element,
          'appid': 'b8310f3831b84652df63321591dabec2',
        },
      ).then((value) {
        currentFiveWeather = CurrentWeather.fromJson(value.data);
        fiveCitiesList.add(currentFiveWeather!);
        emit(TopFiveSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(TopFiveErrorState());
      });
    });

  }


  FiveDayDataModel? fiveDayDataModel;
  List<myList> previosList=[];
  void getPreviosWeatherDate({required String cityName}) {
    emit(PreviusWeatherLoadingState());
    DioHelper.getData(
      url: 'forecast',
      query: {
        'q': cityName,
        'appid': 'b8310f3831b84652df63321591dabec2',
      },
    ).then((value) {
      fiveDayDataModel = FiveDayDataModel.fromJson(value.data);
      previosList = fiveDayDataModel!.previoslist!;
      //previosList.add(fiveDayDataModel!);
      //print(previusWeather!.city);
      emit(PreviusWeatherSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PreviusWeatherErrorState());
    });
  }
}
