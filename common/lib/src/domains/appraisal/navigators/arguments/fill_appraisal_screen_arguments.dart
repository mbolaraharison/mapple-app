import 'package:maple_common/maple_common.dart';

class FillAppraisalScreenArguments {
  final RepresentativeAppraisal representativeAppraisal;
  final Representative editingRepresentative;
  final bool isOwnAppraisal;

  FillAppraisalScreenArguments({
    required this.representativeAppraisal,
    required this.editingRepresentative,
    required this.isOwnAppraisal,
  });
}
