import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_manager/app_manager_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(this.context, State initialState)
      : appManagerBloc = BlocProvider.of<AppManagerBloc>(context),
        super(initialState);

  final AppManagerBloc appManagerBloc;
  final BuildContext context;
}
