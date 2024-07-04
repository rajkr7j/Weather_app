import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/providers/searched_cities.dart';
import 'package:weather_app/screens/detailsScreen/details_screen.dart';
import 'package:weather_app/services/get_weather_animation.dart';

class SearchHistory extends ConsumerStatefulWidget {
  const SearchHistory({super.key});

  @override
  ConsumerState<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends ConsumerState<SearchHistory> {
  late Future<void> _cityFuture;

  @override
  void initState() {
    super.initState();
    _cityFuture = ref.read(searchedCityProvider.notifier).loadCities();
  }

  @override
  Widget build(context) {
    final cityList = ref.watch(searchedCityProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
          future: _cityFuture,
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cityList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 160),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  WeatherDetailScreen(weather: cityList[index]),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: const Color.fromARGB(255, 32, 43, 59),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                //animation
                                SizedBox(
                                  height: height / 10,
                                  width: width / 8,
                                  child: Lottie.asset(
                                    getWeatherAnimations(
                                        cityList[index].mainCondition),
                                    animate: false,
                                  ),
                                ),

                                //space
                                SizedBox(width: width / 18),

                                //city name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cityList[index].cityName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    //searched time
                                    Text(
                                      cityList[index].time,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(149, 255, 255, 255),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                //temperature
                                Text(
                                  '${((cityList[index].temperature) - 273.15).toStringAsFixed(1)}°C',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
