import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MyTextFormBuilder extends StatelessWidget {
  final String name;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator; // Optional custom validator

  const MyTextFormBuilder({
    required this.labelText,
    required this.name,
    this.keyboardType,
    this.validator,  // Validator is optional now
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      keyboardType: keyboardType ??  TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator ?? FormBuilderValidators.compose([FormBuilderValidators.required()]), // Use default validator if none provided
    );
  }
}
