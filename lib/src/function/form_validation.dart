

import 'package:loginapp/components.dart';

String? emailValidation(String? email) {
  if (email == null || email.trim().isEmpty) return "Email can not be empty";

  final regex = RegExp(emailValidationPattern);
  if (!regex.hasMatch(email)) return "Invalid email address";

  return null;
}

String? passwordValidation(String? password) {
  if (password == null || password.trim().isEmpty) return "Password can not be empty";

  if (password.length < passwordMinLength) return "Password must have at least ($passwordMinLength) characters in length";

  return null;
}

String? nameValidation(String? name) {
  if (name == null || name.trim().isEmpty) return "Name can not be empty";

  if (name.length < nameMinLength) return "Name must have at least ($nameMinLength) characters in length";

  RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
  if (!regex.hasMatch(name)) return "Name must not contain any numeric characters or symbol";

  regex = RegExp(r'\s{2,}');
  if (regex.hasMatch(name.trim())) return "Name must not contain multiple white space in row";

  return null;
}

String? phoneNumberValidation(String? number) {
  if (number == null || number.trim().isEmpty) return "Phone number can not be empty";

  if (number.length != phoneNumberLength) return "Phone number must be $phoneNumberLength digits";

  final RegExp regex = RegExp(r'^[0-9]+$');
  if (!regex.hasMatch(number)) return "Phone number must be contain only digits (0-9)";

  return null;
}
