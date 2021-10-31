import 'package:flutter/material.dart';
import 'package:i_charm/utilities/utilities.dart';

class CreateReminderDialog extends StatefulWidget {
  const CreateReminderDialog({Key? key}) : super(key: key);

  @override
  _CreateReminderDialogState createState() => _CreateReminderDialogState();
}

class _CreateReminderDialogState extends State<CreateReminderDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      title: Container(
        // color: secondaryColor,
        child: const Center(
          child: Text(
            'เตือนให้ใส่อีกใน',
            style: TextStyle(color: primaryColor),
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline,
              color: primaryColor,
            ),
          ),
          const Text(
            '00 : 20',
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_circle_outline,
              color: primaryColor,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('ยกเลิก'),
          onPressed: Navigator.of(context).pop,
        ),
        ElevatedButton(
          child: const Text('ยืนยัน'),
          onPressed: () {
            // Navigator.of(context).pop(_stars);
          },
        )
      ],
    );
  }
}
