import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/animations/slide_page.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/views/login/otp_view.dart';
import 'package:i_charm/views/main_view/main_view.dart';
import 'package:i_charm/views/views.dart';
import 'package:path/path.dart';

import 'bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _textPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // shape: CustomShapeBorder(),
          ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => LoginBloc(context.read<AppManagerBloc>()),
          child: _buildStack(),
        ),
      ),
    );
  }

  Stack _buildStack() {
    return Stack(
      children: [
        _buildLoginLayout(),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            Widget view;
            if (state is LoginStateSMSReceivedSuccess) {
              view = OTPView(
                phoneNumber: state.phoneNumber,
                resendToken: state.resendToken,
              );
            } else {
              view = Container();
            }
            return SlidePage(child: view);
          },
        )
      ],
    );
  }

  _buildLoginLayout() {
    return Builder(builder: (context) {
      return Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              const Text('Your phone number'),
              const Text('You will receive an OTP from us'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _phoneNumberFormField(),
              ),
              ElevatedButton(
                onPressed: () => context.read<LoginBloc>().add(
                    LoginEventSubmittedPhoneNumber(_textPhoneController.text)),
                child: const Text('Login'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    TextButton(
                      child: const Text('Register here'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterView(),
                          )),
                    )
                  ],
                ),
              ),
              TextButton(
                child: const Text('See as guest'),
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainView(),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }

  _phoneNumberFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
          controller: _textPhoneController,
          keyboardType: TextInputType.datetime,
          maxLength: 9,
          decoration: const InputDecoration(
            prefix: Text("(+66) "),
            hintText: 'Phone number',
          ),
          validator: (value) {}),
    );
  }
}
