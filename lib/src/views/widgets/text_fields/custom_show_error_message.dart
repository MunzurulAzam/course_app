import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomShowErrorMessage extends StatelessWidget {
  const CustomShowErrorMessage({super.key, this.message = "Something went wrong"});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
  }
}
