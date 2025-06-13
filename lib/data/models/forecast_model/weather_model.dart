class WeatherModel {
  final String cityName;
  final String countaryName;
  final DateTime date;
  final String? image;
  final double maxTemp;
  final double minTemp;
  final double temp;
  final String weatherCondition;
  final int isDay;
  final double windKPH;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.countaryName,
    required this.date,
    this.image,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.weatherCondition,
    required this.isDay,
    required this.windKPH,
    required this.humidity,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
        image: json['forecast']['forecastday'][0]['day']['condition']['icon'],
        cityName: json['location']['name'],
        countaryName: json['location']['country'],
        date: DateTime.parse(json['current']['last_updated']),
        maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
        minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
        temp: json['current']['temp_c'],
        weatherCondition: json['current']['condition']['text'],
        isDay: json["current"]["is_day"],
        windKPH: json["current"]["wind_kph"],
        humidity: json["current"]["humidity"]
        // weatherCondition: json['forecast']['forecastday'][0]['day']['condition']
        //     ['text'],
        );
  }
}
