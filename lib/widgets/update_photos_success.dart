import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_charm/views/smile_gallery/smile_gallery_view.dart';

class UpdatePhotosSuccess extends StatelessWidget {
  const UpdatePhotosSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เรียบร้อย'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/images/check_icon.svg'),
            ),
            const Text(
              'สำเร็จแล้ว',
              style: TextStyle(color: Colors.lightGreen),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('การอัพเดทภาพฟันของคุณสำเร็จแล้ว'),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: SvgPicture.asset('assets/images/close_icon.svg'),
                iconSize: MediaQuery.of(context).size.width * 0.3,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SmileGalleryView(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
