import 'package:flutter/material.dart';

class MyICharmVIew extends StatelessWidget {
  const MyICharmVIew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: IconButton(
                icon: const Icon(Icons.plus_one_outlined),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
