import 'package:easy_localization/easy_localization.dart';

enum Role {
  // Values
  confirmedSalesRep(1),
  fairSalesRep(2),
  agencyDirector(3),
  agencyAnimator(4),
  regionalAnimator(5),
  juniorSalesRep(6),
  technicalManager(7),
  installer(8),
  regionalDirector(9),
  headquartersAnimator(10),
  it(11),
  unknown(0);

  // Constructor
  const Role(this.value);

  // Variables
  final int value;

  // Getters
  String get label => 'role.$name'.tr();

  // Static
  static Role fromValue(int value) {
    return Role.values.firstWhere(
      (element) => element.value == value,
      orElse: () => Role.unknown,
    );
  }
}
