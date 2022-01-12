import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/views/views.dart';
import 'package:i_charm/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class SmileGalleryView extends StatelessWidget {
  const SmileGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMMMd('th');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smile Gallery'),
        centerTitle: true,
      ),
      body: BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
        builder: (context, state) {
          if (state is PatientManagerStateGetInfoSuccess) {
            PatientInfo patientInfo = state.patientInfo;

            return Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      patientInfo.aligner?.uploadImage?.length ?? 0,
                      (index) {
                        String date = patientInfo
                                    .aligner!.uploadImage![index].uploadDate !=
                                null
                            ? dateFormat.format(DateFormat("yyyy-MM-dd").parse(
                                DateTime.fromMillisecondsSinceEpoch(patientInfo
                                        .aligner!
                                        .uploadImage![index]
                                        .uploadDate!
                                        .millisecondsSinceEpoch)
                                    .toString()))
                            : 'ไม่มีข้อมูล';
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    '${patientInfo.aligner!.uploadImage![index].image01}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(date),
                              ],
                            ),
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              List<String> imagesUrl = [];
                              imagesUrl.add(patientInfo
                                  .aligner!.uploadImage![index].image01!);
                              imagesUrl.add(patientInfo
                                  .aligner!.uploadImage![index].image02!);
                              imagesUrl.add(patientInfo
                                  .aligner!.uploadImage![index].image03!);
                              imagesUrl.add(patientInfo
                                  .aligner!.uploadImage![index].image04!);
                              return SmileGalleryDetail(imagesUrl: imagesUrl);
                            })),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const TakePhotoButton(),
              ],
            );
          } else {
            return const Center(
              child: Text('Loading ...'),
            );
          }
        },
      ),
    );
  }
}
