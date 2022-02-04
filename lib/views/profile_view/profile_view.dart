import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';

import '../views.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _menusData = [
      {
        'icon': 'assets/images/icharm_schedule_menu.svg',
        'title': 'Smile gallery',
        'onPressed': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider.value(
                    value: BlocProvider.of<PatientInfoManagerBloc>(context)
                      ..add(PatientManagerEventGetUploadImages()),
                    child: const SmileGalleryView(),
                  );
                },
              ),
            ),
      },
      {
        'icon': 'assets/images/profile/profile_edit_menu.svg',
        'title': 'แก้ไขโปรไฟล์',
      },
      // {
      //   'icon': 'assets/images/profile/profile_contact_us_menu.svg',
      //   'title': 'ติดต่อเรา',
      // },
      {
        'icon': 'assets/images/profile/profile_about_us_menu.svg',
        'title': 'เกี่ยวกับเรา',
      },
      {
        'icon': 'assets/images/profile/profile_logout_menu.svg',
        'title': 'ออกจากระบบ',
        'onPressed': () => BlocProvider.of<AppManagerBloc>(context)
            .add(AppManagerEventLogOutRequested()),
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์'),
        centerTitle: true,
        // shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        // child: Column(
        //   children: _menusData
        //       .map(
        //         (menu) => GestureDetector(
        //           child: Padding(
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        //             child: Row(
        //               children: [
        //                 SvgPicture.asset(menu['icon']),
        //                 const SizedBox(width: 16),
        //                 Text(menu['title']),
        //               ],
        //             ),
        //           ),
        //           onTap: menu['onPressed'],
        //         ),
        //       )
        //       .toList(),
        // ),
        child: Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/icharm_schedule_menu.svg'),
                    const SizedBox(width: 16),
                    const Text('Smile Gallery')
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<PatientInfoManagerBloc>(context)
                        ..add(PatientManagerEventGetUploadImages()),
                      child: const SmileGalleryView(),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        'assets/images/profile/profile_edit_menu.svg'),
                    const SizedBox(width: 16),
                    const Text('แก้ไขโปรไฟล์')
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<PatientInfoManagerBloc>(context),
                      child: EditProfileView(
                        userInfo: context.read<AppManagerBloc>().currentUser!,
                      ),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/about_us.png'),
                    const SizedBox(width: 16),
                    const Text('เกี่ยวกับเรา')
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<PatientInfoManagerBloc>(context)
                        ..add(PatientManagerEventGetUploadImages()),
                      child: const ContactUsView(),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/logout.png'),
                    const SizedBox(width: 16),
                    const Text('ออกจากระบบ')
                  ],
                ),
              ),
              onTap: () => BlocProvider.of<AppManagerBloc>(context)
                  .add(AppManagerEventLogOutRequested()),
            ),
          ],
        ),
      ),
    );
  }
}
