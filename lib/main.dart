import 'package:flutter/material.dart';
import 'package:news_app/controller/api_data_controller.dart';
import 'package:news_app/controller/bottom_navigation_controller.dart';
import 'package:news_app/controller/saved_news_controller.dart';
import 'package:news_app/view/screens/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataController()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationController()),
        ChangeNotifierProvider(create: (context) => SavednewController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}
