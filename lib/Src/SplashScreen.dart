import 'package:flutter/material.dart';
import 'package:fluttertask/Src/HomeScreen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatelessWidget {
  static const img1 = 'lib/assets/img1.jpg';
  static const img2 = 'lib/assets/img2.jpg';

  final List<PageViewModel> pages = [
    _buildPageModel("Welcome", "Discover amazing features", img2, Colors.white),
    _buildPageModel(
        "Get Started", "Create an account to begin.", img1, Colors.white),
    _buildPageModel(
        "Explore", "Explore the app and enjoy!", img2, Colors.white),
  ];

  static PageViewModel _buildPageModel(
      String title, String body, String image, Color color) {
    return PageViewModel(
      title: title,
      decoration: _pageDecoration(color),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Image.asset(image)),
          Container(
              child: Text(
            body,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
        ],
      ),
    );
  }

  static PageDecoration _pageDecoration(Color color) {
    return PageDecoration(
      pageColor: color,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      contentMargin: EdgeInsets.only(top: 50.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () => _navigateToLoginPage(context),
      onSkip: () => _navigateToLoginPage(context),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Colors.blue,
        activeSize: const Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
