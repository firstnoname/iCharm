import 'package:flutter/material.dart';
import 'package:i_charm/widgets/widgets.dart';

class TakePhotoStepper extends StatefulWidget {
  const TakePhotoStepper({Key? key}) : super(key: key);

  @override
  State<TakePhotoStepper> createState() => _TakePhotoStepperState();
}

class _TakePhotoStepperState extends State<TakePhotoStepper> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              steps: <Step>[
                Step(
                  title: const Text('1'),
                  content: Column(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('2'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Home Address'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Postcode'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('3'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Mobile Number'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('4'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Mobile Number'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  switchStepsType() {
    // setState(() => stepperType == StepperType.vertical
    //     ? stepperType = StepperType.horizontal
    //     : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
