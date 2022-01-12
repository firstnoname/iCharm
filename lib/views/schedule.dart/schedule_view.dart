import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/models.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final currentDate = DateTime.now();
  late DateTime _lastDay;
  late DateTime _firstDay;
  late DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _lastDay = DateTime(currentDate.year, currentDate.month, currentDate.day);
    _firstDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day - 99);

    PatientInfo patientInfo =
        context.read<PatientInfoManagerBloc>().patientInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: _firstDay,
              focusedDay: _selectedDay,
              lastDay: _lastDay,
              currentDay: _selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                context.read<PatientInfoManagerBloc>().add(
                    PatientManagerEventGetHistory(
                        queryDate: Timestamp.fromDate(selectedDay)));
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
            BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
              builder: (context, state) {
                List<AlignerHistory> history = [];
                double totalTime = 0.0;
                if (patientInfo.aligner?.alignerHistory != null) {
                  history =
                      patientInfo.aligner!.alignerHistory!.where((element) {
                    bool isEqual = element.createDate!
                                .toDate()
                                .difference(DateTime.now())
                                .inDays ==
                            0
                        ? true
                        : false;
                    if (isEqual == true) {
                      totalTime += double.parse(element.total!);
                    }
                    return isEqual;
                  }).toList();
                }
                return Column(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total: $totalTime hrs.'),
                            Text(
                                'Aligner #${history.isNotEmpty ? history.first.alignerNumber : ''}'),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: history.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                            '${history[index].start ?? ''} PM - ${history[index].end ?? ''} AM (${history[index].total ?? ''} hrs.)'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: SingleChildScrollView(
    //     child: BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
    //       builder: (context, state) {
    //         if (state is PatientManagerStateGetInfoSuccess) {
    //           PatientInfo patientInfo =
    //               context.read<PatientInfoManagerBloc>().patientInfo;
    //           List<AlignerHistory> history = [];
    //           if (patientInfo.aligner?.alignerHistory != null) {
    //             List<AlignerHistory> history =
    //                 patientInfo.aligner!.alignerHistory!;
    //           }

    //           // if (patientInfo.aligner!.alignerHistory!.isNotEmpty) {
    //           //   _selectedDay = patientInfo
    //           //           .aligner?.alignerHistory?[0].createDate
    //           //           ?.toDate() ??
    //           //       DateTime.now();
    //           // }

    //           return Column(
    //             children: [
    //               TableCalendar(
    //                 firstDay: _firstDay,
    //                 focusedDay: _selectedDay,
    //                 lastDay: _lastDay,
    //                 currentDay: _selectedDay,
    //                 onDaySelected: (selectedDay, focusedDay) {
    //                   context.read<PatientInfoManagerBloc>().add(
    //                       PatientManagerEventGetHistory(
    //                           queryDate: Timestamp.fromDate(selectedDay)));
    //                   setState(() {
    //                     _selectedDay = selectedDay;
    //                   });
    //                 },
    //               ),
    //               Container(
    //                 color: Colors.grey[200],
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: const [
    //                       Text('Total: 22 hrs 45 mins'),
    //                       Text('Aligner #4'),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
    //                 builder: (context, state) {
    //                   return ListView.builder(
    //                     shrinkWrap: true,
    //                     itemCount: history.length,
    //                     itemBuilder: (context, index) => ListTile(
    //                       title: Text(
    //                           '${history[index].start ?? ''} PM - ${history[index].end ?? ''} AM (${history[index].total ?? ''} hrs.)'),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ],
    //           );
    //         } else {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
