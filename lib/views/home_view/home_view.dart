import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 5;

    List<Map<String, dynamic>> _menusData = [
      {
        'icon': 'assets/images/my_icharm_menu.svg',
        'title': 'My iCHARM',
        'navigation': '',
      },
      {
        'icon': 'assets/images/icharm_schedule_menu.svg',
        'title': 'Schedule',
        'navigation': '',
      },
      {
        'icon': 'assets/images/find_icharm_menu.svg',
        'title': 'Find iCHARM',
        'navigation': '',
      },
      {
        'icon': 'assets/images/qa_menu.svg',
        'title': 'Q&A',
        'navigation': '',
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าหลัก'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text('Hi, What would you like to do today?'),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: _menusData
                  .map(
                    (menu) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyICharmVIew(),
                          )),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              menu['icon'],
                              height: _imageSize,
                              width: _imageSize,
                            ),
                            const SizedBox(height: 8),
                            Text(menu['title']),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
