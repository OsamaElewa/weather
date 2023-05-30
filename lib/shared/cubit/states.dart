abstract class WeatherState{}

class WeatherInitialState extends WeatherState{}

class WeatherLoadingState extends WeatherState{}
class WeatherSuccessState extends WeatherState{}
class WeatherErrorState extends WeatherState{}

class TopFiveLoadingState extends WeatherState{}
class TopFiveSuccessState extends WeatherState{}
class TopFiveErrorState extends WeatherState{}

class PreviusWeatherLoadingState extends WeatherState{}
class PreviusWeatherSuccessState extends WeatherState{}
class PreviusWeatherErrorState extends WeatherState{}