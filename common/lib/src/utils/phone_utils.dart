// Interface:-------------------------------------------------------------------
abstract class PhoneUtilsInterface {
  String format(String phone);

  String formatWithCode(String phone);
}

// Implementation:--------------------------------------------------------------
class PhoneUtils implements PhoneUtilsInterface {
  PhoneUtils();

  @override
  String format(String phone) {
    String formattedPhone = phone;
    if (formattedPhone.trim() == '') {
      return '';
    }
    // check if phone does not start with +33
    if (formattedPhone.startsWith('+33')) {
      return formattedPhone.replaceFirst('+33', '0').replaceAll(' ', '');
    }
    // check if phone does not start with 0
    if (!formattedPhone.startsWith('0')) {
      return '0$formattedPhone'.replaceAll(' ', '');
    }
    return formattedPhone.replaceAll(' ', '');
  }

  @override
  String formatWithCode(String phone) {
    String formattedPhone = phone;
    if (formattedPhone.trim() == '') {
      return '';
    }
    // check if phone does start with +33
    if (formattedPhone.startsWith('+33')) {
      return formattedPhone.replaceAll(' ', '');
    }
    // check if phone does not start with +33
    if (formattedPhone.startsWith('0')) {
      return formattedPhone.replaceFirst('0', '+33').replaceAll(' ', '');
    }

    return '+33$formattedPhone'.replaceAll(' ', '');
  }
}
