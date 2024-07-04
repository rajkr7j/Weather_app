import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double visiblity;
  final String time;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visiblity,
    required this.time,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    String formatCurrentTime() {
      final now = DateTime.now();
      final formatter = DateFormat('h:mma');
      return formatter.format(now).toLowerCase();
    }

    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      visiblity: json['visibility'].toDouble(),
      time: formatCurrentTime(),
    );
  }
}
