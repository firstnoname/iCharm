import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/views/login/phone_auth_form.dart';

import 'bloc/register_bloc.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User _userInfo = User();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียน'),
        centerTitle: true,
        // shape: CustomShapeBorder(),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(context),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "รหัส ID จาก iCHARM",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            // if (val.length == 0) {
                            //   return "Email cannot be empty";
                            // } else {
                            //   return null;
                            // }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "ชื่อ",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  // if (val.length == 0) {
                                  //   return "Email cannot be empty";
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (newValue) =>
                                    _userInfo.firstName = newValue,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "นามสกุล",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  // if (val.length == 0) {
                                  //   return "Email cannot be empty";
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (newValue) =>
                                    _userInfo.lastName = newValue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            // if (val.length == 0) {
                            //   return "Email cannot be empty";
                            // } else {
                            //   return null;
                            // }
                          },
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => _userInfo.email = newValue,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            formKey.currentState?.save();
                            _userInfo.id = context
                                .read<AppManagerBloc>()
                                .appAuth
                                .firebaseCurrentUser!
                                .uid;
                            _userInfo.phoneNumber = '';
                            context
                                .read<RegisterBloc>()
                                .add(RegisterEventSubmit(userInfo: _userInfo));
                          },
                          child: const Text('ลงทะเบียน'))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
