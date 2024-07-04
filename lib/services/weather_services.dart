import 'dart:convert';

import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey'));

    if (response.statusCode == 200) {
      print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
