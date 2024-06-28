import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';

class OrderFormContactDto {
  String fullName;
  String phone;
  String mobilePhone;
  String email;

  OrderFormContactDto({
    required this.fullName,
    required this.phone,
    required this.mobilePhone,
    required this.email,
  });

  void verify() {
    if (fullName.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.contact_dto.full_name'.tr());
    }
    if (mobilePhone.isEmpty && phone.isEmpty) {
      throw DtoException('order_form.generate_errors.contact_dto.phone'.tr());
    }
    if (email.isEmpty) {
      throw DtoException('order_form.generate_errors.contact_dto.email'.tr());
    }
  }
}
