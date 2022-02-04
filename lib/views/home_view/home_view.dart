import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 5;
    var navigator = 'navigator';

    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าหลัก'),
        centerTitle: true,
      ),
      body: BlocBuilder<PatientInfoManagerBloc, PatientInfoManagerState>(
        builder: (context, state) {
          List<Map<String, dynamic>> _menusData = [
            {
              'icon': 'assets/images/my_icharm_menu.svg',
              'title': 'My iCHARM',
              navigator: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<PatientInfoManagerBloc>(),
                          child: const MyICharmVIew(),
                        );
                      },
                    ),
                  ),
            },
            {
              'icon': 'assets/images/icharm_schedule_menu.svg',
              'title': 'Schedule',
              navigator: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        context.read<PatientInfoManagerBloc>().add(
                            PatientManagerEventGetHistory(
                                queryDate: Timestamp.fromDate(DateTime.now()
                                    .subtract(const Duration(
                                        hours: 0, minutes: 0)))));
                        return BlocProvider.value(
                          value: context.read<PatientInfoManagerBloc>(),
                          child: const ScheduleView(),
                        );
                      },
                    ),
                  ),
            },
            {
              'icon': 'assets/images/find_icharm_menu.svg',
              'title': 'Find iCHARM',
              navigator: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FindICharm())),
            },
            {
              'icon': 'assets/images/qa_menu.svg',
              'title': 'Q&A',
              navigator: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuestionAndAnswer(),
                    ),
                  )
            }
          ];
          return SingleChildScrollView(
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
                          onTap: menu[navigator] as void Function()?,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    // child: ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       width: MediaQuery.of(context).size.width / 1.4,
                    //       padding: const EdgeInsets.symmetric(horizontal: 8),
                    //       child: Card(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //         ),
                    //         child: SvgPicture.asset(
                    //           'assets/test_banner.svg',
                    //           fit: BoxFit.fill,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/test_banner_1.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/test_banner_2.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/test_banner_3.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/test_banner_4.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
