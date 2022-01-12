import 'package:flutter/material.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';
import 'package:i_charm/models/models.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  final User userInfo;
  const EditProfileView({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _nameTextController;
  late TextEditingController _lastNameTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController =
        TextEditingController(text: widget.userInfo.firstName);
    _lastNameTextController =
        TextEditingController(text: widget.userInfo.lastName);
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _lastNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูล'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('ข้อมูลบัญชี'),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _nameTextController,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _lastNameTextController,
                  )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                child: ElevatedButton(
                  child: const Text('บันทึก'),
                  onPressed: () {
                    context.read<AppManagerBloc>().add(
                          AppManagerEventProfileSubmitted(
                            userInfo: User(
                              firstName: _nameTextController.text,
                              lastName: _lastNameTextController.text,
                            ),
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
