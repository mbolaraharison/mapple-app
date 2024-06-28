import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';

class OrderFormRepresentativeDto {
  final String fullName;
  final String phone;
  final String email;
  final bool showPhone;
  final bool showEmail;

  OrderFormRepresentativeDto({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.showPhone,
    required this.showEmail,
  });

  void verify() {
    if (fullName.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.representative_dto.full_name'.tr());
    }
  }
}
