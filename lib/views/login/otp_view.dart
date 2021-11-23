import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  '_localization!.title',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              FittedBox(
                child: Text(
                  widget.phoneNumber,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Color.fromRGBO(115, 115, 115, 1),
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
              constraints: BoxConstraints(maxWidth: 300),
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
                  // onSaved: (value) =>
                  //     BlocProvider.of<LoginViewBloc>(context).smsCode = value,
                  // animationType: AnimationType.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('_localization!.resendDescription'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(4.0),
                    primary: Theme.of(context).accentColor,
                  ),
                  // onPressed: () => BlocProvider.of<LoginViewBloc>(context).add(
                  //   LoginViewEventResentOTP(),
                  // ),
                  onPressed: () {},
                  child: Text('_localization!.resend'),
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
                        // BlocProvider.of<LoginViewBloc>(context)
                        //     .add(LoginViewEventPhoneCodeSubmitted());
                      }
                    : null,
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  // AppManagerBloc.of(context).dismissKeyboard(context);
                  // BlocProvider.of<LoginViewBloc>(context)
                  //     .add(LoginViewEventClosedOTPView());
                },
                child:
                    Text(MaterialLocalizations.of(context).cancelButtonLabel))
          ],
        );
      },
    );
  }
}
