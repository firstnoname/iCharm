import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/models.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatelessWidget {
  ScheduleView({Key? key}) : super(key: key);
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final lastDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 364);
    final firstDay =
        DateTime(currentDate.year, currentDate.month, currentDate.day - 364);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
          builder: (context, state) {
            if (state is PatientManagerStateGetInfoSuccess) {
              PatientInfo patientInfo =
                  context.read<PatientInfoManagerBloc>().patientInfo;
              final focusedDay = patientInfo
                      .aligner?.alignerHistory?[0].createDate
                      ?.toDate() ??
                  DateTime.now();
              print('first date -> $firstDay');
              print('focused date -> $focusedDay');
              print('last date -> $lastDay');
              return Column(
                children: [
                  TableCalendar(
                    firstDay: firstDay,
                    focusedDay: focusedDay,
                    lastDay: lastDay,
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total: 22 hrs 45 mins'),
                          Text('Aligner #4'),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: patientInfo.aligner?.alignerHistory != null
                        ? patientInfo.aligner?.alignerHistory!.length
                        : 0,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                          '${patientInfo.aligner?.alignerHistory?[index].start ?? ''} PM - ${patientInfo.aligner?.alignerHistory?[index].end ?? ''} AM (${patientInfo.aligner?.alignerHistory?[index].total ?? ''} hrs 00 mins)'),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Loading ... '),
              );
            }
          },
        ),
      ),
    );
  }
}
