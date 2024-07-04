import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/searched_cities.dart';
import 'package:weather_app/screens/detailsScreen/mobile_ui.dart';
import 'package:weather_app/screens/detailsScreen/tablet_ui.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherDetailScreen extends ConsumerStatefulWidget {
  const WeatherDetailScreen({super.key, required this.weather});
  final Weather weather;

  @override
  ConsumerState<WeatherDetailScreen> createState() =>
      _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends ConsumerState<WeatherDetailScreen> {
  //weather detail
  Weather? cityWeather;
  @override
  void initState() {
    super.initState();
    refreshWeather();
    cityWeather = widget.weather;
  }

  //api key
  final weatherService =
      WeatherService(apiKey: '748b16c4cc2d054cf85fb6e0f78986f2');

  //refresh weather data of selected city
  Future<void> refreshWeather() async {
    if (widget.weather.cityName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PLEASE ENTER A CITY TO SEARCH WEATHER'),
        ),
      );
      return;
    }
    try {
      final data =
          await weatherService.getWeather(widget.weather.cityName.trim());

      setState(() {
        cityWeather = data;
      });

      //this will update the history with new updated data
      ref.read(searchedCityProvider.notifier).addCity(cityWeather!);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Weather Updated Successfully'),
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 19, 30),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather Conditions',
          style: TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 19, 30),
        actions: [
          TextButton(
            onPressed: refreshWeather,
            child: const Row(
              children: [
                Text(
                  'REFRESH',
                  style: TextStyle(
                    color: Color.fromARGB(118, 0, 213, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.refresh,
                  color: Color.fromARGB(118, 0, 213, 255),
                )
              ],
            ),
          )
        ],
      ),
      body: height > width
          ? MobileUi(
              weather: cityWeather!,
            )
          : TabletUi(
              weather: cityWeather!,
            ),
    );
  }
}
