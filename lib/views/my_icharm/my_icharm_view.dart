import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/patient/patient_info.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';
import 'package:i_charm/widgets/widgets.dart';

class MyICharmVIew extends StatelessWidget {
  const MyICharmVIew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PatientInfo _patientInfo;
    double _circleSize = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
        buildWhen: (previous, current) {
          if (current is PatientManagerStateUploadImageSuccess) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is PatientManagerStateGetInfoSuccess) {
            _patientInfo = state.patientInfo;
            return SingleChildScrollView(
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
                                      builder: (context) => ScheduleView(),
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
                                  children: [
                                    Text(
                                      '${_patientInfo.alignerInfo!.currentAligner} of ${_patientInfo.alignerInfo!.totalAligner}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
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
                    const TakePhotoButton(),
                  ],
                ),
              ),
            );
          } else if (state is PatientManagerStateFailure) {
            return const Center(
              child: Text('fail'),
            );
          } else {
            return const Center(
              child: Text('Loading ... '),
            );
          }
        },
      ),
    );
  }
}
