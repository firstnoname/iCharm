import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';

class ICharmApp extends StatelessWidget {
  const ICharmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AppManagerBloc(),
        )
      ],
      child: MaterialApp(
        theme: appTheme(),
        home: _buildApp(),
      ),
    );
  }

  _buildApp() {
    return BlocBuilder<AppManagerBloc, AppManagerState>(
      builder: (context, state) {
        Widget displayWidget = const Text('test');

        return Scaffold(
          body: Center(child: displayWidget),
        );
      },
    );
  }
}
