import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  late double _height;
  late double _width;

  double percent = 0.0;

  @override
  void initState() {
    late Timer timer;
    timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      print('Percent Update');
      setState(() {
        percent += 1;
        if (percent >= 100) {
          timer.cancel();
          // percent=0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 130,
      width: 130,
      child: LiquidCircularProgressIndicator(
        value: percent / 100,
        // Defaults to 0.5.
        valueColor: const AlwaysStoppedAnimation(primaryColor),
        backgroundColor: secondaryColor,
        borderColor: primaryColor,
        borderWidth: 4.0,
        direction: Axis.vertical,
        center: Text(
          percent.toString() + "%",
          style: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120) //and back to the origin, could not be necessary #1
      ..close();
  }
}
