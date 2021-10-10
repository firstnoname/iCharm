import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';

class ICharmApp extends StatelessWidget {
  const ICharmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      home: _buildHome(),
    );
  }

  _buildHome() {
    return const SplashScreen();
  }
}
