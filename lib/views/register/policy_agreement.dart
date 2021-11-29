import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/views/register/register_view.dart';

class PolicyAgreement extends StatelessWidget {
  const PolicyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                  child: Center(child: Text('Policy and Agreement'))),
              ElevatedButton(
                child: const Text('ตกลง'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterView()),
                ),
              ),
              ElevatedButton(
                child: const Text('ออกจากระบบ'),
                onPressed: () => BlocProvider.of<AppManagerBloc>(context).add(
                  AppManagerEventLogOutRequested(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
