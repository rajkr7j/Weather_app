import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/get_weather_animation.dart';
import 'package:weather_app/widget/grid_item.dart';

class MobileUi extends StatefulWidget {
  const MobileUi({super.key, required this.weather});
  final Weather weather;

  @override
  State<MobileUi> createState() => _MobileUiState();
}

class _MobileUiState extends State<MobileUi> {
  @override
  Widget build(context) {
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: height / 25),
          //city name

          Text(
            widget.weather.cityName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),

          //animation
          Lottie.asset(getWeatherAnimations(widget.weather.mainCondition)),

          //weather condition
          Text(
            widget.weather.mainCondition,
            style: const TextStyle(fontSize: 20),
          ),

          //temperature
          Text(
            '${((widget.weather.temperature) - 273.15).toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),

          //other details
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25.0, // Spacing between columns
              mainAxisSpacing: 25.0,
              // childAspectRatio: 1, // Spacing between rows
            ),
            children: [
              GridItem(
                title: 'HUMIDITY',
                data: '${widget.weather.humidity.toString()} %',
                icon: 'assets/humidity.json',
              ),
              GridItem(
                title: 'WIND SPEED',
                data: '${widget.weather.windSpeed.toString()} m/s',
                icon: 'assets/wind speed.json',
              ),
              GridItem(
                title: 'PRESSURE',
                data: '${widget.weather.pressure.toString()} hPa',
                icon: 'assets/pressure.json',
              ),
              GridItem(
                title: 'VISIBILITY',
                data: '${(widget.weather.visiblity / 1000).toString()} km',
                icon: 'assets/visibility.json',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
