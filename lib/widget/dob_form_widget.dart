import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDateTimePickerWidget extends StatelessWidget {
  const FormBuilderDateTimePickerWidget({
    super.key,
    // required GlobalKey<FormBuilderFieldState<FormBuilderField, dynamic>> dobFieldKey,
  }) ;
  // : _dobFieldKey = dobFieldKey;

 // final GlobalKey<FormBuilderFieldState<FormBuilderField, dynamic>> _dobFieldKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
    //  key: _dobFieldKey,
      name: 'date',
      inputType: InputType
          .both, // You can choose InputType.date or InputType.time
      decoration: const InputDecoration(
        labelText: 'Select Date and Time',
        border: OutlineInputBorder(),
      ),
      //  initialValue: DateTime.now(),
      // firstDate: DateTime(2000), // optional
      // lastDate: DateTime(2100), // optional
    );
  }
}
