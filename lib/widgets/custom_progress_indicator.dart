import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CustomProgressIndicator extends StatefulWidget {
  final double percents;
  const CustomProgressIndicator({Key? key, required this.percents})
      : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  late double _height;
  late double _width;

  @override
  void initState() {
    // late Timer timer;
    // timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
    //   print('Percent Update');
    //   setState(() {
    //     percent += 1;
    //     if (percent >= 100) {
    //       timer.cancel();
    //       // percent=0;
    //     }
    //   });
    // });
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
        value: widget.percents / 100,
        valueColor: const AlwaysStoppedAnimation(primaryColor),
        backgroundColor: secondaryColor,
        borderColor: primaryColor,
        borderWidth: 4.0,
        direction: Axis.vertical,
        center: Text(
          widget.percents.toStringAsFixed(2) + "%",
          style: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
