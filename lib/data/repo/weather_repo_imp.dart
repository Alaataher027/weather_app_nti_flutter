import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_nti/core/api/api_client.dart';
import 'package:weather_app_nti/core/api/api_constants.dart';
import 'package:weather_app_nti/core/errors/failures.dart';
import 'package:weather_app_nti/data/models/forecast_model/hourly_weather_model.dart';
import 'package:weather_app_nti/data/models/forecast_model/next_days_weather_model.dart';
import 'package:weather_app_nti/data/models/search_model/search_model.dart';
import 'package:weather_app_nti/data/models/forecast_model/weather_model.dart';
import 'package:weather_app_nti/data/repo/weather_repo.dart';

class WeatherRepoImp extends WeatherRepo {
  final ApiClient apiClient;

  WeatherRepoImp(this.apiClient);

  @override
  Future<Either<Failures, WeatherModel>> fetchCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      var data = await apiClient.getWeather(
        endPoint: "forecast.json?q=$lat,$lon&key=${ApiConstants.apiKey}&days=1",
      );

      final forecastModel = WeatherModel.fromJson(data);

      return right(forecastModel);
    } on Exception catch (e) {
      if (e is DioException) {
        print("from DioException : $e");
        return left(ServerFailure.fromDioException(e));
      }
      print("ServerFailure : $e");
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<HourlyWeatherModel>>> fetchHourlyTodayWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      var data = await apiClient.getWeather(
        endPoint: "forecast.json?q=$lat,$lon&key=${ApiConstants.apiKey}&days=1",
      );

      final hours = data['forecast']?['forecastday']?[0]?['hour'];

      if (hours != null) {
        List<HourlyWeatherModel> hourlyWeather = [];

        for (var hour in hours) {
          hourlyWeather.add(HourlyWeatherModel.fromJson(hour));
        }

        return right(hourlyWeather);
      } else {
        return left(ServerFailure("No hourly data found"));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<NextDaysWeather>>> fetchNextDaysWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      var data = await apiClient.getWeather(
        endPoint: "forecast.json?q=$lat,$lon&key=${ApiConstants.apiKey}&days=7",
      );

      final forecastDays = data['forecast']['forecastday'];

      List<NextDaysWeather> nextDaysList = [];

      for (var day in forecastDays) {
        nextDaysList.add(NextDaysWeather.fromJson(day));
      }

      if (nextDaysList.isNotEmpty) {
        return right(nextDaysList);
      } else {
        return left(ServerFailure("No data found"));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<SearchModel>>> fetchSearchResults({
    required String cityName,
  }) async {
    try {
      var data = await apiClient.getSearch(
        endPoint: "search.json?q=$cityName&key=${ApiConstants.apiKey}",
      );

      List<SearchModel> searchResults = [];
      for (var item in data) {
        try {
          searchResults.add(SearchModel.fromJson(item));
        } catch (e) {
          print(item);
        }
      }

      return right(searchResults);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
