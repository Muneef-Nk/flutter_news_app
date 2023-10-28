import 'package:flutter/material.dart';
import 'package:news_app/controller/homescreen_controller.dart';
import 'package:news_app/controller/bottom_navigation_controller.dart';
import 'package:news_app/controller/saved_news_controller.dart';
import 'package:news_app/controller/search_scren_controller.dart';
import 'package:news_app/view/screens/splash_screen/splash_screen.dart';
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
        ChangeNotifierProvider(create: (context) => HomescreenController()),
        ChangeNotifierProvider(create: (context) => SearchScreenController()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationController()),
        ChangeNotifierProvider(create: (context) => SavedNewsController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
