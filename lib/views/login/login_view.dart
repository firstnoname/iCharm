import 'package:flutter/material.dart';
import 'package:i_charm/views/main_view/main_view.dart';
import 'package:i_charm/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // shape: CustomShapeBorder(),
          ),
      body: SingleChildScrollView(
        child: Form(
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainView(),
                    )),
                child: const Text('Login'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Don\'t have an account?'),
                    Text('Register here')
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  _phoneNumberFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
          initialValue: '',
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
