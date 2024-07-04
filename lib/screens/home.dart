import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/searched_cities.dart';
import 'package:weather_app/screens/detailsScreen/details_screen.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widget/search_history.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //boolean to check if it is fetching the weather data(initially false)
  bool isFetching = false;
  //cityName text controller
  TextEditingController cityName = TextEditingController();

  //weather detail
  Weather? weather;

  //api key
  final weatherService =
      WeatherService(apiKey: '748b16c4cc2d054cf85fb6e0f78986f2');

  //fetch weather
  Future<void> fetchWeather() async {
    if (cityName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PLEASE ENTER A CITY TO SEARCH WEATHER'),
        ),
      );
      return;
    }
    try {
      setState(() {
        isFetching = true;
      });
      final data = await weatherService.getWeather(cityName.text.trim());

      setState(() {
        weather = data;
      });

      ref.read(searchedCityProvider.notifier).addCity(weather!);
      setState(() {
        isFetching = false;
        cityName.text = '';
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => WeatherDetailScreen(weather: weather!)));
    } catch (e) {
      setState(() {
        isFetching = false;
      });
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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 19, 30),
      body: Stack(children: [
        Column(
          children: [
            SizedBox(height: height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              //city name search box and search button
              child: Row(
                children: [
                  Expanded(
                    //Enter City Name
                    child: TextField(
                      controller: cityName,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter City Name',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(131, 255, 255, 255)),
                        filled: true,
                        fillColor: Color.fromARGB(255, 32, 43, 59),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 32, 43, 59)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 32, 43, 59)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Search button
                  IconButton(
                    onPressed: fetchWeather,
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 4, 81, 145),
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),

            //remove search history
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      ref.read(searchedCityProvider.notifier).deleteAllCities,
                  child: const Row(
                    children: [
                      Icon(Icons.clear_all),
                      Text('Clear All'),
                    ],
                  ),
                ),
              ],
            ),

            //Search History of weather
            const SearchHistory(),
          ],
        ),
        if (isFetching)
          Container(
            color: const Color.fromARGB(66, 158, 158, 158),
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.green,
            )),
          ),
      ]),
    );
  }
}
