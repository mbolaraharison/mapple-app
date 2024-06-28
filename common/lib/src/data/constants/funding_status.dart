import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum FundingStatus {
  A('funding_status.under_review'), // Under Review
  B('funding_status.approved'), // Approved
  C('funding_status.released'), // Released
  D('funding_status.none'); // None

  const FundingStatus(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<SelectChoice<FundingStatus>> get choices => FundingStatus.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}
