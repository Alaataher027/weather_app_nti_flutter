import 'package:dartz/dartz.dart';
import 'package:weather_app_nti/core/errors/failures.dart';
import 'package:weather_app_nti/data/models/forecast_model/hourly_weather_model.dart';
import 'package:weather_app_nti/data/models/forecast_model/next_days_weather_model.dart';
import 'package:weather_app_nti/data/models/search_model/search_model.dart';
import 'package:weather_app_nti/data/models/forecast_model/weather_model.dart';

abstract class WeatherRepo {
  Future<Either<Failures, WeatherModel>> fetchCurrentWeather({
    required double lat,
    required double lon,
  });

  Future<Either<Failures, List<HourlyWeatherModel>>> fetchHourlyTodayWeather({
    required double lat,
    required double lon,
  });
  Future<Either<Failures, List<NextDaysWeather>>> fetchNextDaysWeather({
    required double lat,
    required double lon,
  });

  Future<Either<Failures, List<SearchModel>>> fetchSearchResults({
    required String cityName,
  });
}
