import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/get_weather_animation.dart';

class TabletUi extends StatefulWidget {
  const TabletUi({super.key, required this.weather});
  final Weather weather;

  @override
  State<TabletUi> createState() => _TabletUiState();
}

class _TabletUiState extends State<TabletUi> {
  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox(width: width / 20),
        Container(
          width: width / 2.5,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              children: [
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
                Lottie.asset(
                    getWeatherAnimations(widget.weather.mainCondition)),

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
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25.0, // Spacing between columns
              mainAxisSpacing: 25.0,
              // childAspectRatio: 1, // Spacing between rows
            ),
            children: [
              GridItemTab(
                title: 'HUMIDITY',
                data: '${widget.weather.humidity.toString()} %',
                icon: 'assets/humidity.json',
              ),
              GridItemTab(
                title: 'WIND SPEED',
                data: '${widget.weather.windSpeed.toString()} m/s',
                icon: 'assets/wind speed.json',
              ),
              GridItemTab(
                title: 'PRESSURE',
                data: '${widget.weather.pressure.toString()} hPa',
                icon: 'assets/pressure.json',
              ),
              GridItemTab(
                title: 'VISIBILITY',
                data: '${(widget.weather.visiblity / 1000).toString()} km',
                icon: 'assets/visibility.json',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridItemTab extends StatelessWidget {
  const GridItemTab({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });
  final String title;
  final String data;
  final String icon;

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 43, 59),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(131, 255, 255, 255), fontSize: 15),
          ),
          Text(
            data,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
          Expanded(
            child: Lottie.asset(
              icon,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
