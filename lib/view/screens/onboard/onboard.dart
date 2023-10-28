import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/utils/color_constant.dart';
import 'package:news_app/view/screens/bottom_navigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,

      pages: [
        PageViewModel(
          title: "Get the latest news from reliable sources",
          body:
              "Access up-to-the-minute news from trusted sources you can rely on. Stay informed with accurate and timely updates from credible news outlets.",
          image: Lottie.asset("assets/animation/dr.json"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get actual news from around the world",
          body:
              "Stay informed with real-time global news coverage. Get the latest updates and insights on current events, politics, culture, and more from every corner of the world",
          image: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Lottie.asset("assets/animation/tech.json"),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          title: "Sports, Politics, health, & anything",
          body:
              "Explore the world of Sports, Politics, Health, and more. Stay updated on the latest developments, trends, and stories that matter to you.",
          image: Lottie.asset("assets/animation/sport.json"),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
      ],
      onDone: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isNewUser', true);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      },
      onSkip: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }, // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,

      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: Colors.white,
        size: Size(10.0, 10.0),
        // color: primary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
