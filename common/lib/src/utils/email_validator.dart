// Interface:-------------------------------------------------------------------
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EmailValidatorInterface {
  RegExp get emailRegExp;

  bool validate(String email);
  bool validateForBrand(String email);
}

// Implementation:--------------------------------------------------------------
class EmailValidator implements EmailValidatorInterface {
  @override
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  bool validate(String email) {
    return emailRegExp.hasMatch(email);
  }

  @override
  bool validateForBrand(String email) {
    return validate(email) && email.endsWith(dotenv.env["BRAND_DOMAIN"] ?? '');
  }
}
