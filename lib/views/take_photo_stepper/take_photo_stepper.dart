import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/patient_manager/bloc/patient_info_manager_bloc.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/take_photo_stepper/camera_layout.dart';
import 'package:i_charm/widgets/widgets.dart';

import 'package:im_stepper/stepper.dart';

import 'bloc/take_photo_bloc.dart';

class TakePhotoStepper extends StatefulWidget {
  const TakePhotoStepper({Key? key}) : super(key: key);

  @override
  State<TakePhotoStepper> createState() => _TakePhotoStepperState();
}

class _TakePhotoStepperState extends State<TakePhotoStepper> {
  int activeStep = 0;

  int upperBound = 2;

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget build(BuildContext ctx) {
    bool isShowLoading = false;
    Map<int, String>? imagesPath;
    return BlocListener<PatientInfoManagerBloc, PatientInfoManagerState>(
      listener: (context, state) {
        if (state is PatientManagerStateUploadImageSuccess) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return BlocProvider.value(
              value: context.read<PatientInfoManagerBloc>(),
              child: const UpdatePhotosSuccess(),
            );
          }));
        }
      },
      child: BlocProvider(
        create: (ctx) => TakePhotoBloc(),
        child: BlocBuilder<TakePhotoBloc, TakePhotoState>(
          buildWhen: (previous, current) {
            if (current is TakePhotoStateAddedImagePathSuccess) {
              return true;
            } else if (current is TakePhotoStateInProgress) {
              return true;
            } else {
              return false;
            }
          },
          builder: (ctx, state) {
            if (state is TakePhotoStateAddedImagePathSuccess) {
              imagesPath = state.imagePath;
            } else if (state is TakePhotoStateInProgress) {
              isShowLoading = true;
            }
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () => showDialog<String>(
                            context: ctx,
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<PatientInfoManagerBloc>(
                                  context),
                              child: AlertDialog(
                                title: const Text('ยืนยันข้อมูล'),
                                content: const Text(
                                    'ยืนยันข้อมูลและส่งข้อมูลไปยังแพทย์'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'ยกเลิก'),
                                    child: const Text('ยกเลิก'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<TakePhotoBloc>(ctx)
                                          .add(TakePhotoEventInProgress());
                                      BlocProvider.of<PatientInfoManagerBloc>(
                                              context)
                                          .add(PatientManagerUploadedImages(
                                              imagesPath: ctx
                                                  .read<TakePhotoBloc>()
                                                  .imagesPath
                                                  .values
                                                  .toList()));

                                      Navigator.pop(context, 'ตกลง');
                                    },
                                    child: const Text('ตกลง'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: const Icon(Icons.check_circle),
                        ),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberStepper(
                          activeStepBorderColor: primaryColor,
                          activeStepColor: primaryColor,
                          numbers: const [1, 2, 3, 4],
                          numberStyle: const TextStyle(color: Colors.white),
                          stepRadius: 12,
                          scrollingDisabled: true,
                          activeStep: activeStep,
                          // This ensures step-tapping updates the activeStep.
                          onStepReached: (index) {
                            setState(() {
                              activeStep = index;
                            });
                          },
                        ),
                      ),
                      CameraLayout(
                        activeStep: activeStep,
                        imagePath: imagesPath?[activeStep] ?? '',
                      ),
                    ],
                  ),
                ),
                isShowLoading
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
