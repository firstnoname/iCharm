import 'package:flutter/material.dart';
import 'package:i_charm/services/services.dart';
import 'package:i_charm/views/views.dart';

class FindICharm extends StatefulWidget {
  const FindICharm({Key? key}) : super(key: key);

  @override
  _FindICharmState createState() => _FindICharmState();
}

class _FindICharmState extends State<FindICharm> {
  final keywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ค้นหาบริการ'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.maps_home_work),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FindICharmMap(),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const Text('ค้นหาบริการจาก ICharm ใกล้บ้านคุณ'),
            TextField(
              controller: keywordController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('ค้นหา'),
              onPressed: () async {
                var clinics =
                    await ClinicAPI().getClinics(keywordController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FindICharmDetail(clinics: clinics)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
