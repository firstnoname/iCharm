import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_charm/blocs/blocs.dart';

class CameraLayout extends StatefulWidget {
  final int activeStep;
  const CameraLayout({Key? key, required this.activeStep}) : super(key: key);

  @override
  _CameraLayoutState createState() => _CameraLayoutState();
}

class _CameraLayoutState extends State<CameraLayout> {
  late CameraController _controller;

  late Future<void> _initializeControllerFuture;

  String imagePath = '';

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      BlocProvider.of<AppManagerBloc>(context).firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          imagePath == ''
              ? Expanded(
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the Future is complete, display the preview.
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CameraPreview(_controller),
                              widget.activeStep == 0
                                  ? SvgPicture.asset(
                                      'assets/images/photo_frame/frame_1.svg',
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    )
                                  : widget.activeStep == 1
                                      ? SvgPicture.asset(
                                          'assets/images/photo_frame/frame_2.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        )
                                      : widget.activeStep == 2
                                          ? SvgPicture.asset(
                                              'assets/images/photo_frame/frame_3.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                            )
                                          : Container(),
                            ],
                          ),
                        );
                      } else {
                        // Otherwise, display a loading indicator.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
              : Expanded(child: Image.file(File(imagePath))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.activeStep == 0
                  ? Row(
                      children: [
                        Image.asset('assets/images/photo_frame/example_1.png'),
                        const Flexible(
                            child: Text(
                                '1/4 กัดฟันด้านหลังของคุณอย่างช้าๆ และยิ้ม')),
                      ],
                    )
                  : widget.activeStep == 1
                      ? Row(
                          children: [
                            Image.asset(
                                'assets/images/photo_frame/example_2.png'),
                            const Flexible(
                                child: Text(
                                    '2/4 ยกมือถือของคุณขึ้น อ้าปากกว้างๆ ให้เราสามารถเห็นฟันล่างด้านหน้าของคุณ โดยไม่ให้ริมฝีปากนั้นบัง')),
                          ],
                        )
                      : widget.activeStep == 2
                          ? Row(
                              children: [
                                Image.asset(
                                    'assets/images/photo_frame/example_3.png'),
                                const Flexible(
                                    child: Text(
                                        '3/4 เอียงมือถือของคุณลง อ้าปากกว้างๆ ให้เราสามารถเห็นฟันบนด้านหน้าของคุณโดยไม่ให้ริมฝีปากนั้นบัง')),
                              ],
                            )
                          : Row(
                              children: [
                                Image.asset(
                                    'assets/images/photo_frame/example_4.png'),
                                const Flexible(
                                    child: Text(
                                        '4/4 หันหน้าไปด้านข้าง หุบฟันด้านหลังให้สม่ำเสมอกันทั้ง2  ข้าง')),
                              ],
                            )),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => setState(() {
                          imagePath = '';
                        })),
                IconButton(
                  icon: const Icon(Icons.camera_enhance),
                  onPressed: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    try {
                      // Ensure that the camera is initialized.
                      await _initializeControllerFuture;

                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      final image = await _controller.takePicture();

                      setState(() {
                        imagePath = image.path;
                      });
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                ),
                const Icon(CupertinoIcons.switch_camera),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
