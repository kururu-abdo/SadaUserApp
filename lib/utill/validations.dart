import 'package:email_validator/email_validator.dart';

bool isEmail(String input) => EmailValidator.validate(input);

bool isPhone(String input) => RegExp(
  r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
).hasMatch(input);