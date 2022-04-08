import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flipper/constants/const.dart';
import 'package:flipper/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      // backgroundColor: primaryColor,
      logo: const Image(
        image: AssetImage('assets/images/icon.png'),
      ),
      navigator: const HomePage(),
      loaderColor: primaryColor,
    );
  }
}
