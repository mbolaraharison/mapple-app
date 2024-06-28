import 'package:easy_localization/easy_localization.dart';

class ResetPasswordException implements Exception {
  late final String message;

  ResetPasswordException(String code) {
    switch (code) {
      case 'expired-action-code':
        message = 'auth.errors.expired_action_code'.tr();
        break;
      case 'invalid-action-code':
        message = 'auth.errors.invalid_action_code'.tr();
        break;
      case 'user-disabled':
        message = 'auth.errors.user_disabled'.tr();
        break;
      case 'user-not-found':
        message = 'auth.errors.user_not_found'.tr();
        break;
      case 'missing-email':
        message = 'auth.errors.missing_email'.tr();
        break;
      case 'invalid-email':
        message = 'auth.errors.invalid_email'.tr();
        break;
      case 'weak-password':
        message = 'auth.errors.weak-password'.tr();
        break;
      default:
        message = 'Une erreur est survenue.';
    }
  }
}
