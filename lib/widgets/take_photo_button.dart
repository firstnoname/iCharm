import 'package:flutter/material.dart';
import 'package:i_charm/views/views.dart';

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
        ),
      ),
    );
  }
}
