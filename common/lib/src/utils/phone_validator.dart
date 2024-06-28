// Interface:-------------------------------------------------------------------
abstract class PhoneValidatorInterface {
  RegExp get mobilePhoneRegExp;
  RegExp get phoneRegExp;

  bool validate(String phone, {bool mobile = false});
}

// Implementation:--------------------------------------------------------------
class PhoneValidator implements PhoneValidatorInterface {
  @override
  final RegExp mobilePhoneRegExp = RegExp(r'^(0|\+33)[67]\d{8}$');

  @override
  final RegExp phoneRegExp = RegExp(r'^(0|\+33)[1-9]\d{8}$');

  @override
  bool validate(String phone, {bool mobile = false}) {
    if (mobile) {
      return mobilePhoneRegExp.hasMatch(phone);
    }
    return phoneRegExp.hasMatch(phone);
  }
}
