import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/view/screens/bottom_navigation/bottom_navigation.dart';
import 'package:news_app/view/screens/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isLoading() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool('isNewUser') == true
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomNavigation()))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OnBoardingPage()));
    });
  }

  @override
  void initState() {
    isLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("The News",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red)),
        Center(
            child: Lottie.asset("assets/animation/loading.json", width: 150)),
      ],
    ));
  }
}
