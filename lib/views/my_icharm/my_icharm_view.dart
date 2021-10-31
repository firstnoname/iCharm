import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';
import 'package:i_charm/widgets/widgets.dart';

class MyICharmVIew extends StatelessWidget {
  const MyICharmVIew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _circleSize = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: secondaryColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {},
                        ),
                        const Text('Change to Aligner #4'),
                      ],
                    ),
                    const SizedBox(
                      height: 150,
                      width: 150,
                      child: CustomProgressIndicator(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                            'assets/images/my_icharm/play_pause_icon.svg'),
                        IconButton(
                          icon: SvgPicture.asset(
                              'assets/images/my_icharm/reminder_icon.svg'),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return const CreateReminderDialog();
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/images/my_icharm/calendar_icon.svg'),
                              const SizedBox(width: 8),
                              const Text(
                                'ใน 100 วัน',
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ScheduleView(),
                              ))),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ClipOval(
                      child: Container(
                        color: secondaryColor,
                        height: _circleSize,
                        width: _circleSize,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '4 of 12',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Current Aligner',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: ClipOval(
                      child: Container(
                        color: secondaryColor,
                        height: _circleSize,
                        width: _circleSize,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '4 days to',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Next aligner',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  child: const Text('Tips & Tricks'),
                  onPressed: () {},
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('ถ่ายรูปฟันของคุณ'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TakePhotoStepper(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
