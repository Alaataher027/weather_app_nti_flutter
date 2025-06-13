class NextDaysWeather {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String weatherCondition;

  NextDaysWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherCondition,
  });

  factory NextDaysWeather.fromJson(Map<String, dynamic> json) {
    return NextDaysWeather(
      date: json['date'] ?? '',
      minTemp: json['day']['mintemp_c'],
      maxTemp: json['day']['maxtemp_c'],
      weatherCondition: json['day']['condition']['text'],
    );
  }
}
