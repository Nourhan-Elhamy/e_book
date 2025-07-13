import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/features/splash/new.dart';

import 'features/home/data/home_data.dart';

void main() {
  runApp(MyApp());
   BookRepository bookRepository=BookRepository();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Haven',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        scaffoldBackgroundColor: Colors.brown[100],
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[200],
          foregroundColor: Colors.brown[900],
          elevation: 0,
        ),
      ),
      home: AdvancedSplashScreen(),
    );
  }
}

