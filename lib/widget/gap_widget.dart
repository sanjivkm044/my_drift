import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double? height;
  const Gap({
    super.key,
     this.height,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: height ?? 10.0);
  }
}