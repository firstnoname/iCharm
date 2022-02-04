import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/utilities.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ติดต่อเรา'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: const Text(
                  'Tel : 086-4308072',
                  style: TextStyle(color: primaryColor, fontSize: 18),
                ),
                onPressed: () async {
                  if (!await launch('tel:0864308072')) {
                    throw 'Could not launch 0864308072';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: const Text(
                  'Email : icharmaligner@gmail.com',
                  style: TextStyle(color: primaryColor, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  child: const Text(
                    'Facebook : IcharmClearAligner',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: const Text(
                  'Line ID : @icharm',
                  style: TextStyle(color: primaryColor, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
