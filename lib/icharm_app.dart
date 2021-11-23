import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/utilities/utilities.dart';
import 'package:i_charm/views/views.dart';

class ICharmApp extends StatelessWidget {
  final CameraDescription firstCamera;
  const ICharmApp({Key? key, required this.firstCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) =>
              AppManagerBloc(firstCamera)..add(AppManagerEventInitialApp()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: _buildApp(),
      ),
    );
  }

  _buildApp() {
    return BlocBuilder<AppManagerBloc, AppManagerState>(
      builder: (context, state) {
        Widget displayWidget = const Text('test');

        if (state is AppManagerInitialInProgress) {
          displayWidget = const SplashScreen();
        } else if (state is AppManagerStateAuthenticated) {
          displayWidget = const MainView();
        } else {
          displayWidget = LoginView();
        }
        return displayWidget;
      },
    );
  }
}
