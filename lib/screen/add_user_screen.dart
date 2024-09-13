
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_drift/db/db_service.dart';
import 'package:my_drift/widget/dob_form_widget.dart';
import 'package:my_drift/widget/gap_widget.dart';
import 'package:my_drift/widget/text_form_builder_widget.dart';
import 'package:drift/drift.dart' as drift;

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Users"),
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
                  const Gap(),
                  SizedBox(
                    width: 200,
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final formValues = _formKey.currentState?.value;
                          final entity = UserCompanion(
                            name: drift.Value(formValues?['name'] ?? ''),
                            email: drift.Value(formValues?['email'] ?? ''),
                            phone:
                                drift.Value<String>(formValues?['phone'] ?? ''),
                            dateOfBirth:
                                drift.Value(formValues?['dateOfBirth'] ?? ''),
                          );

                          AppDatabase()
                              .userDao
                              .insertData(entity)
                              .then(
                                (values) => Flushbar(
                                  backgroundColor: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                  title: "User inserted sucessfully",
                                  message:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                  duration: const Duration(seconds: 3),
                                ),
                              )
                              .catchError((entity) => print(entity));
                          Navigator.pop(context);
                          return;
                        } else {
                          debugPrint('Form validation failed');
                        }
                      },
                      child: const Text(
                        'Add User',
                        style: TextStyle(color: Colors.white),
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
