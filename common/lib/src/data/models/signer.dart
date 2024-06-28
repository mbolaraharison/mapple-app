import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

class Signer<T extends SignerModel> implements SelectForSignatureBaseModel {
  Signer(
      {required this.signer,
      required this.initials,
      required this.signed,
      required this.model});

  final T signer;
  bool signed;
  final SelectForSignatureBaseModel model;

  @override
  final String initials;

  @override
  String get id => signer.recipientId;

  bool get isEmailEmpty => signer.email.trim() == '';

  bool get isEmailValid {
    String trimmedEmail = signer.email.trim();
    // check if email is valid
    return getIt<EmailValidatorInterface>().validate(trimmedEmail);
  }

  bool get isPhoneEmpty {
    if (signer.smsAuthentication == null) {
      return true;
    }
    if (signer.smsAuthentication!.senderProvidedNumbers.isEmpty) {
      return true;
    }
    return signer.smsAuthentication!.senderProvidedNumbers[0].trim() == '';
  }

  bool get isPhoneValid {
    if (isPhoneEmpty) {
      return false;
    }
    String trimmedPhone =
        signer.smsAuthentication!.senderProvidedNumbers[0].trim();
    // check if phone is valid
    return getIt<PhoneValidatorInterface>()
        .validate(trimmedPhone, mobile: true);
  }

  bool get isPhoneValidForSignature {
    return !isPhoneEmpty && isPhoneValid;
  }

  bool get isEmailValidForSignature {
    return !isEmailEmpty && isEmailValid;
  }

  @override
  bool get isValidForSignature {
    return isEmailValidForSignature && isPhoneValidForSignature;
  }

  @override
  String get shortFullName => signer.name;

  @override
  List<String> get signingAbilityStatusInfosList {
    List<String> infos = [];
    if (isEmailEmpty) {
      infos.add('customer.error_infos.email_empty'.tr());
    }
    if (!isEmailEmpty && !isEmailValid) {
      infos.add('customer.error_infos.email_invalid'.tr());
    }
    if (isPhoneEmpty) {
      infos.add('customer.error_infos.phone_empty'.tr());
    }
    if (!isPhoneEmpty && !isPhoneValid) {
      infos.add('customer.error_infos.phone_invalid'.tr());
    }
    return infos;
  }

  @override
  String get signingAbilityStatusInfos {
    return signingAbilityStatusInfosList.join('\n');
  }
}
