import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherapp2/models/previos_weather_model.dart';
import 'package:weatherapp2/models/weather_model.dart';
import 'package:weatherapp2/shared/cubit/cubit.dart';
import 'package:weatherapp2/shared/cubit/states.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var weatherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WeatherCubit.get(context).currentWeather;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sky.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: TextFormField(
                          controller: weatherController,
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            BlocProvider.of<WeatherCubit>(context)
                                .getCurrentWeatherDate(cityName: value);

                            WeatherCubit.get(context).getPreviosWeatherDate(cityName: value);
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                //gapPadding: 10.0
                              ),
                              //hintText: 'Search',
                              label: const Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.0, 1.0),
                        child: Container(
                          color: Colors.red,
                          height: 10,
                          width: 10,
                          child: OverflowBox(
                            minWidth: 0.0,
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: (MediaQuery.of(context).size.height / 4),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              width: double.infinity,
                              height: double.infinity,
                              //color: Colors.white,
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      cubit != null
                                          ? '${BlocProvider.of<WeatherCubit>(context).currentWeather!.name}'
                                          : '',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      DateFormat()
                                          .add_MMMMEEEEd()
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              cubit != null
                                                  ? '${cubit.weather![0].description}'
                                                  : '',
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              cubit != null
                                                  ? '${(cubit.main!.temp! - 274.15).round().toString()}\u2103'
                                                  : '',
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 35),
                                            ),
                                            Text(
                                              cubit != null
                                                  ? 'min:${(cubit.main!.tempMin! - 273.15).round().toString()}\u2103 / max:${(cubit.main!.tempMax! - 273.15).round().toString()}\u2103'
                                                  : '',
                                              style: const TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              decoration:  BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(cubit !=null? 'http://openweathermap.org/img/w/${cubit.weather![0].icon!}.png':''),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              width: 90,
                                              height: 90,
                                            ),
                                            Text(cubit != null
                                                ? 'wind: ${cubit.wind!.speed} m/s'
                                                : ''),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 90),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OTHER CITY',
                          style: TextStyle(color: Colors.black38, fontSize: 18),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(),
                            itemCount:
                                WeatherCubit.get(context).fiveCitiesList.length,
                            itemBuilder: (context, index) => buildList(
                                WeatherCubit.get(context)
                                    .fiveCitiesList[index]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'FORCAST NEXT FIVE DAYS',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.next_plan_outlined,
                              color: Colors.black45,
                            )
                          ],
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            width: double.infinity,
                            height: 220,
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <
                                  ChartSeries<myList, String>>[
                                SplineSeries<myList,String>(
                                  dataSource: WeatherCubit.get(context).previosList,
                                  xValueMapper: (myList f,_) => f.dtTxt,
                                  yValueMapper: (myList f,_) => f.main!.temp,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildList(CurrentWeather model) => Container(
      width: 140,
      height: 140,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.name!),
            Text('${(model.main!.temp! - 273.15).round().toString()}\u2103'),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('http://openweathermap.org/img/w/${model.weather![0].icon}.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Text('${model.weather![0].description}')
          ],
        ),
      ),
    );
