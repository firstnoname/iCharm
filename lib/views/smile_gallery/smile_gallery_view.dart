import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 300,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.amber,
                  child: Center(child: Text('$index')),
                );
              },
            ),
          ),
          const TakePhotoButton(),
        ],
      ),
    );
  }
}
