import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_charm/views/login/bloc/login_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPView extends StatefulWidget {
  final String phoneNumber;
  final int? resendToken;
  const OTPView(
      {Key? key, required this.phoneNumber, required this.resendToken})
      : super(key: key);

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final formKey = GlobalKey<FormState>();
  var readyToSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: SizedBox.fromSize(
          size: MediaQuery.of(context).size,
          child: Column(
            children: [
              Expanded(
                  child: SvgPicture.asset(
                      "assets/images/splash_screen_welcome_logo.svg")),
              FittedBox(
                child: Text(
                  'กรุณาใส่รหัส OTP',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              FittedBox(
                child: Text(
                  'ที่ส่งไปยังเบอร์ +66${widget.phoneNumber}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: const Color.fromRGBO(115, 115, 115, 1),
                      ),
                ),
              ),
              Expanded(child: _buildInputArea()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Form(
                key: formKey,
                child: PinCodeTextField(
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    if (value.length == 6) {
                      setState(() {
                        readyToSubmit = true;
                      });
                    } else if (readyToSubmit) {
                      setState(() {
                        readyToSubmit = false;
                      });
                    }
                  },
                  onSaved: (value) {
                    print('otp -> $value');
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginEventOTPSubmitted(otpCode: value ?? ''));
                  },
                  animationType: AnimationType.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ไม่ได้รับรหัส?'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(4.0),
                    primary: Theme.of(context).accentColor,
                  ),
                  // onPressed: () => BlocProvider.of<LoginViewBloc>(context).add(
                  //   LoginViewEventResentOTP(),
                  // ),
                  onPressed: () {},
                  child: const Text('ส่งใหม่'),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 250),
              child: ElevatedButton(
                onPressed: readyToSubmit
                    ? () {
                        formKey.currentState?.save();
                        // BlocProvider.of<LoginBloc>(context)
                        //     .add(const LoginEventOTPSubmitted(otpCode: ''));
                      }
                    : null,
                child: const Text('ตกลง'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {

                  // AppManagerBloc.of(context).dismissKeyboard(context);
                  BlocProvider.of<LoginBloc>(context)
                      .add(LoginEventOTPViewClosed());
                },
                child: const Text('ยเลิก'))
          ],
        );
      },
    );
  }
}
