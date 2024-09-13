
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBarWidget extends StatelessWidget {
  const FlushBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.blue,
      borderRadius: BorderRadius.circular(8),
      title: "User inserted sucessfully",
      message:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      duration: const Duration(seconds: 3),
    );
  }
}
