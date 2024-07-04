import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/screens/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme:
              GoogleFonts.signikaTextTheme().apply(bodyColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 154, 154, 154)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          )),
      home: const HomeScreen(),
    );
  }
}
