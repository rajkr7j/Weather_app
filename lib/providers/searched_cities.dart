import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:weather_app/models/weather.dart';

Future<Database> _getDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, 'cities.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE searched_cities(name TEXT PRIMARY KEY, temp REAL, mainCondition TEXT, humidity REAL, windspeed REAL, pressure REAL, visibility REAL, time TEXT)');
  }, version: 1);
  return db;
}

class SearchedCityNotifier extends StateNotifier<List<Weather>> {
  SearchedCityNotifier() : super([]);

  Future<void> loadCities() async {
    final db = await _getDatabase();
    final data = await db.query('searched_cities');
    final cities = data
        .map(
          (city) => Weather(
              cityName: city['name'] as String,
              temperature: city['temp'] as double,
              mainCondition: city['mainCondition'] as String,
              humidity: city['humidity'] as double,
              windSpeed: city['windspeed'] as double,
              pressure: city['pressure'] as double,
              visiblity: city['visibility'] as double,
              time: city['time'] as String),
        )
        .toList();
    state = cities;
  }

  void addCity(Weather newCity) async {
    final db = await _getDatabase();
    db.insert(
      'searched_cities',
      {
        'name': newCity.cityName,
        'temp': newCity.temperature,
        'mainCondition': newCity.mainCondition,
        'humidity': newCity.humidity,
        'windspeed': newCity.windSpeed,
        'pressure': newCity.windSpeed,
        'visibility': newCity.visiblity,
        'time': newCity.time,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    //update the state
    final cities =
        state.where((city) => city.cityName != newCity.cityName).toList();
    state = [newCity, ...cities];
  }

  Future<void> deleteAllCities() async {
    final db = await _getDatabase();
    await db.delete('searched_cities');

    //clear state
    state = [];
  }
}

final searchedCityProvider =
    StateNotifierProvider<SearchedCityNotifier, List<Weather>>(
        (ref) => SearchedCityNotifier());
