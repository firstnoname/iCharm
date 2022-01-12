import 'package:flutter/material.dart';

class SmileGalleryDetail extends StatelessWidget {
  final List<String> imagesUrl;
  const SmileGalleryDetail({Key? key, required this.imagesUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: imagesUrl.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  imagesUrl[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
