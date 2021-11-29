import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/views/views.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(255, 227, 219, 1),
        child: SizedBox.expand(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Image.asset('assets/icons/splash_screen_logo.png'),
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                      'assets/images/splash_screen_welcome_logo.svg'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
