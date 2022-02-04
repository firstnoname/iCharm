import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CustomProgressIndicator extends StatefulWidget {
  final double percents;
  final double remainingTime;
  const CustomProgressIndicator(
      {Key? key, required this.percents, required this.remainingTime})
      : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: LiquidCircularProgressIndicator(
        value: widget.percents / 100,
        valueColor: const AlwaysStoppedAnimation(primaryColor),
        backgroundColor: secondaryColor,
        borderColor: primaryColor,
        borderWidth: 4.0,
        direction: Axis.vertical,
        center: Text(
          widget.remainingTime > 0 ? widget.remainingTime.toString() : '00:00',
          style: const TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
