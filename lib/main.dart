import 'dart:async';  
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';


import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);// Ensure Flutter bindings are initialized

  await FlutterDownloader.initialize(
    debug: false, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true, // optional: set to false to disable working with http links (default: false)
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ECE LAB COMPANION',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
        brightness: Brightness.light),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}



// Ensure Flutter bindings are initialized



// Set up the global action method



