// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../../models/weather_model.dart';
// class WeatherService{
//   String baseUrl='https://api.openweathermap.org/data/2.5';
//   String abiKey='9f382716847a547fa87f3a6eaf715a31';
//   Future<WeatherModel> getWeather({required String cityName})async{
//     Uri url=Uri.parse('$baseUrl/weather?q=$cityName&appid=$abiKey');
//     http.Response response=await http.get(url);
//
//     if(response.statusCode==400){
//       var data =json.decode(response.body);
//       print('error message');
//     }
//      Map<String,dynamic> data= jsonDecode(response.body);
//     WeatherModel model=WeatherModel.fromJson(data);
//     return model;
//   }
// }