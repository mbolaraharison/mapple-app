import 'package:maple_common/maple_common.dart';

class RecipientsModel {
  late final List<CarbonCopyModel> carbonCopies;
  late final List<SignerModel> signers;

  RecipientsModel({
    required this.carbonCopies,
    required this.signers,
  });

  RecipientsModel.fromJson(Map<String, dynamic> json)
      : carbonCopies = json['carbonCopies'],
        signers = json['signers'];

  Map<String, dynamic> toJson() => {
        'carbonCopies': carbonCopies.map((e) => e.toJson()).toList(),
        'signers': signers.map((e) => e.toJson()).toList(),
      };
}
