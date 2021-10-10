import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/widgets/custom_shape_border.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _menusData = [
      {
        'icon': 'assets/images/profile/profile_edit_menu.svg',
        'title': 'แก้ไขโปรไฟล์',
      },
      {
        'icon': 'assets/images/profile/profile_contact_us_menu.svg',
        'title': 'ติดต่อเรา',
      },
      {
        'icon': 'assets/images/profile/profile_about_us_menu.svg',
        'title': 'เกี่ยวกับเรา',
      },
      {
        'icon': 'assets/images/profile/profile_logout_menu.svg',
        'title': 'ออกจากระบบ',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์'),
        centerTitle: true,
        // shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _menusData
              .map((menu) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(menu['icon']),
                        const SizedBox(width: 16),
                        Text(menu['title']),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
