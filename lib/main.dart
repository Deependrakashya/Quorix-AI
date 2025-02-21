import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta_mind/home/homeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure edge-to-edge UI is handled correctly
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Makes status bar transparent
    systemNavigationBarColor: Colors.black, // Transparent navbar
    systemNavigationBarContrastEnforced: false, // Avoids forced contrast
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.white,
      title: 'Deep Mind AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
