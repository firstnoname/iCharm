import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/take_photo_stepper/camera_layout.dart';
import 'package:i_charm/widgets/widgets.dart';

import 'package:im_stepper/stepper.dart';

class TakePhotoStepper extends StatefulWidget {
  const TakePhotoStepper({Key? key}) : super(key: key);

  @override
  State<TakePhotoStepper> createState() => _TakePhotoStepperState();
}

class _TakePhotoStepperState extends State<TakePhotoStepper> {
  int activeStep = 0;

  int upperBound = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('ยืนยันข้อมูล'),
                  content: const Text('ยืนยันข้อมูลและส่งข้อมูลไปยังแพทย์'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                      child: const Text('ยกเลิก'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'ตกลง');
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const UpdatePhotosSuccess()));
                      },
                      child: const Text('ตกลง'),
                    ),
                  ],
                ),
              ),
              child: const Icon(Icons.check_circle),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NumberStepper(
              activeStepBorderColor: primaryColor,
              activeStepColor: primaryColor,
              numbers: const [1, 2, 3, 4],
              numberStyle: const TextStyle(color: Colors.white),
              stepRadius: 12,
              scrollingDisabled: true,
              activeStep: activeStep,
              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
          ),
          CameraLayout(activeStep: activeStep),
        ],
      ),
    );
  }
}
