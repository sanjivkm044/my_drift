
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_drift/db/db_service.dart';
import 'package:my_drift/widget/dob_form_widget.dart';
import 'package:my_drift/widget/gap_widget.dart';
import 'package:my_drift/widget/text_form_builder_widget.dart';
import 'package:drift/drift.dart' as drift;

class UpdateUserScreen extends StatefulWidget {
  final UserData user;

  const UpdateUserScreen({
    super.key,
    required this.user,
  });

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    // Initialize the form with existing user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentState != null) {
        _formKey.currentState?.patchValue({
          'name': widget.user.name,
          'phone': widget.user.phone,
          'email': widget.user.email,
          'dateOfBirth': widget.user.dateOfBirth,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update Users"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const MyTextFormBuilder(
                    name: "name",
                    labelText: "Name",
                  ),
                  const Gap(),
                  const MyTextFormBuilder(
                    name: "phone",
                    labelText: "Phone",
                  ),
                  const Gap(),
                  MyTextFormBuilder(
                    name: 'email',
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const Gap(),
                  const FormBuilderDateTimePickerWidget(),
                  // const Gap(),
                  // const MyTextFormBuilder(
                  //   name: "password",
                  //   labelText: "Password",
                  //   // Ensure password is obscured
                  // ),
                  const Gap(),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final formValues = _formKey.currentState?.value;
                          final entity = UserCompanion(
                            id: drift.Value(widget.user.id),
                            name: drift.Value(formValues?['name'] ?? ''),
                            email: drift.Value(formValues?['email'] ?? ''),
                            phone:
                                drift.Value<String>(formValues?['phone'] ?? ''),
                            dateOfBirth:
                                drift.Value(formValues?['dateOfBirth'] ?? ''),
                          );

                          AppDatabase().userDao.updateUsers(entity);
                           Navigator.pop(context);
                          Flushbar(
                            backgroundColor: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                            title: "Success",
                            message: "User updated successfully.",
                            duration: const Duration(seconds: 3),
                          ).show(context);

                         
                          

                        }
                      },
                      child: const Text(
                        'Update User',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
