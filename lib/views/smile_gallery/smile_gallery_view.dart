import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/widgets/widgets.dart';

import '../views.dart';

class SmileGalleryView extends StatelessWidget {
  const SmileGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: patientInfo.aligner!.uploadImage!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.amber,
                        child: Center(
                          child: Image.network(
                            '${patientInfo.aligner!.uploadImage![index].image01}',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
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
