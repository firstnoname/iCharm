import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/views/login/phone_auth_form.dart';

import 'bloc/register_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        // shape: CustomShapeBorder(),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(context),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Form(
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
                            labelText: "ID Code of iCHARM",
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
                                keyboardType: TextInputType.emailAddress,
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
                                keyboardType: TextInputType.emailAddress,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _phoneTextController,
                          maxLength: 9,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            prefix: const Text('(+66) '),
                            labelText: "เบอร์โทร",
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
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => context.read<RegisterBloc>().add(
                              RegisterEventSubmit(_phoneTextController.text)),
                          child: const Text('Register'))
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
