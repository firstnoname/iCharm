import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/patient/aligner_history.dart';
import 'package:i_charm/models/patient/patient_info.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';
import 'package:i_charm/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyICharmVIew extends StatefulWidget {
  const MyICharmVIew({Key? key}) : super(key: key);

  @override
  State<MyICharmVIew> createState() => _MyICharmVIewState();
}

class _MyICharmVIewState extends State<MyICharmVIew> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late PatientInfo _patientInfo;

  bool isStart = false;
  late Timestamp startTime;
  late SharedPreferences prefs;

  Future<void> _counterStart(Timestamp startTime) async {
    prefs = await _prefs;
    prefs.setInt('startTime', startTime.millisecondsSinceEpoch);
  }

  Future<Timestamp> _getStartTime() async {
    prefs = await _prefs;
    print(
        'startTime -> ${Timestamp.fromMillisecondsSinceEpoch(prefs.getInt('startTime') ?? 0)}');
    return Timestamp.fromMillisecondsSinceEpoch(prefs.getInt('startTime') ?? 0);
  }

  Future _clearStartTime() async {
    prefs = await _prefs;
    prefs.clear();
    print(
        '${Timestamp.fromMillisecondsSinceEpoch(prefs.getInt('startTime') ?? 0)}');
  }

  @override
  Widget build(BuildContext context) {
    double _circleSize = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My iCharm'),
      ),
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
            List<AlignerHistory> currentDateHistories =
                _patientInfo.aligner!.alignerHistory!.where((history) {
              bool isEqual = history.createDate!
                          .toDate()
                          .difference(DateTime.now())
                          .inDays ==
                      0
                  ? true
                  : false;

              return isEqual;
            }).toList();

            double hours = 0.0;
            double percents = 0.0;
            for (var history in currentDateHistories) {
              hours += double.parse(history.total!);
            }
            percents = (hours / 22) * 100;

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
                              Text(
                                  'Change to Aligner #${_patientInfo.alignerInfo!.currentAligner! + 1}'),
                            ],
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: CustomProgressIndicator(percents: percents),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FutureBuilder(
                                  future: _getStartTime(),
                                  builder: (context,
                                      AsyncSnapshot<Timestamp> snapshot) {
                                    if (snapshot.hasData) {
                                      startTime = snapshot.data!;

                                      if (startTime.millisecondsSinceEpoch !=
                                          0) {
                                        isStart = true;
                                      } else {
                                        startTime = Timestamp
                                            .fromMillisecondsSinceEpoch(0);
                                        isStart = false;
                                      }
                                    } else {
                                      startTime =
                                          Timestamp.fromMillisecondsSinceEpoch(
                                              0);
                                      isStart = false;
                                    }

                                    return GestureDetector(
                                      child: isStart == false
                                          ? SvgPicture.asset(
                                              'assets/images/my_icharm/play_pause_icon.svg')
                                          : const Icon(Icons.pause),
                                      onTap: () async {
                                        if (isStart == false) {
                                          _counterStart(Timestamp.fromDate(
                                              DateTime.now()));
                                          setState(() {
                                            isStart = true;
                                          });
                                        } else {
                                          startTime = await _getStartTime();
                                          DateTime currentTime = DateTime.now();
                                          context
                                              .read<PatientInfoManagerBloc>()
                                              .add(
                                                PatientManagerEventAddHistory(
                                                  AlignerHistory(
                                                    createDate:
                                                        Timestamp.fromDate(
                                                            currentTime),
                                                    start:
                                                        '${startTime.toDate().hour}.${startTime.toDate().minute}',
                                                    end:
                                                        '${DateTime.now().hour}.${DateTime.now().minute}',
                                                    total:
                                                        '${DateTime.now().hour - startTime.toDate().hour}.${DateTime.now().minute - startTime.toDate().minute}',
                                                  ),
                                                ),
                                              );
                                          _clearStartTime();

                                          setState(() {
                                            isStart = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('เพิ่มข้อมูลสำเร็จ'),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }),
                              IconButton(
                                icon: SvgPicture.asset(
                                    'assets/images/my_icharm/reminder_icon.svg'),
                                onPressed: () => showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) {
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
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (_) {
                                        return BlocProvider.value(
                                          value: context
                                              .read<PatientInfoManagerBloc>()
                                            ..add(PatientManagerEventGetHistory(
                                                queryDate: Timestamp.fromDate(
                                                    DateTime.now().subtract(
                                                        const Duration(
                                                            hours: 0,
                                                            minutes: 0))))),
                                          child: const ScheduleView(),
                                        );
                                      },
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
