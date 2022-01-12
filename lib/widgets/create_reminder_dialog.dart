import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';

class CreateReminderDialog extends StatefulWidget {
  const CreateReminderDialog({Key? key}) : super(key: key);

  @override
  _CreateReminderDialogState createState() => _CreateReminderDialogState();
}

class _CreateReminderDialogState extends State<CreateReminderDialog> {
  DateTime remindTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
              bottom: BorderSide(
                color: Color(0xff999999),
                width: 0.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: const Text('ยกเลิก'),
                onPressed: () => Navigator.pop(context),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              ),
              CupertinoButton(
                child: const Text('ยืนยัน'),
                onPressed: () {
                  NotificationServices.showScheduleNotification(
                      title: 'แจ้งเตือนเกี่ยวกับ aligner',
                      body: 'ถึงเวลาใส่ aligner',
                      payload: '',
                      scheduleDate: remindTime);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ตั้งเวลาสำเร็จ')));
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.2,
          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                remindTime = DateTime(
                  remindTime.year,
                  remindTime.month,
                  remindTime.day,
                  newDateTime.hour,
                  newDateTime.minute,
                );
              });
            },
            use24hFormat: true,
            minuteInterval: 1,
          ),
        ),
      ],
    );
    // return AlertDialog(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(15),
    //     ),
    //   ),
    //   title: const Center(
    //     child: Text(
    //       'เตือนให้ใส่อีกใน',
    //       style: TextStyle(color: primaryColor),
    //     ),
    //   ),
    //   content: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       IconButton(
    //         onPressed: () {
    //           setState(() {
    //             // rawTime + 10;
    //           });
    //         },
    //         icon: const Icon(
    //           Icons.add_circle_outline,
    //           color: primaryColor,
    //         ),
    //       ),
    //       Text(
    //         '',
    //         style: TextStyle(
    //           color: primaryColor,
    //         ),
    //       ),
    //       IconButton(
    //         onPressed: () {
    //           setState(() {
    //             // rawTime - 10;
    //           });
    //         },
    //         icon: const Icon(
    //           Icons.remove_circle_outline,
    //           color: primaryColor,
    //         ),
    //       ),
    //     ],
    //   ),
    //   actions: <Widget>[
    //     TextButton(
    //       child: const Text('ยกเลิก'),
    //       onPressed: Navigator.of(context).pop,
    //     ),
    //     ElevatedButton(
    //       child: const Text('ยืนยัน'),
    //       onPressed: () {
    //         // Navigator.of(context).pop(_stars);
    //       },
    //     )
    //   ],
    // );
  }
}
