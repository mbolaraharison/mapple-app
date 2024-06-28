import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/domains/ui/types/select_choice.dart';

enum SigningMethod {
  P('signing_method.paper'), // Paper
  E('signing_method.electronic'); // Electronic

  const SigningMethod(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<SelectChoice<SigningMethod>> get choices => SigningMethod.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}
