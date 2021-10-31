import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              focusedDay: DateTime.now(),
              lastDay: DateTime.now(),
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
              itemCount: 3,
              itemBuilder: (context, index) => const ListTile(
                title: Text('8.15 PM - 10.00 AM (14 hrs 15 mins)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
