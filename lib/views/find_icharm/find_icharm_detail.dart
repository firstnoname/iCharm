import 'package:flutter/material.dart';
import 'package:i_charm/models/models.dart';

class FindICharmDetail extends StatelessWidget {
  final List<Clinic> clinics;
  const FindICharmDetail({Key? key, required this.clinics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: clinics.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: clinics.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  debugPrint('Card tapped.');
                                },
                                child: SizedBox(
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Dr.Charmer Ceram'),
                                      Text('${clinics[i].clinicName}'),
                                      Text(
                                        '${clinics[i].address!.addressNo}, ${clinics[i].address!.street}. ${clinics[i].address!.district}. ${clinics[i].address!.subDistrict}, ${clinics[i].address!.province}, ${clinics[i].address!.postcode}',
                                      ),
                                      Text('${clinics[i].url}'),
                                      Text('${clinics[i].tel}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )
          : const Center(
              child: Text('ไม่พบข้อมูล'),
            ),
    );
  }
}
