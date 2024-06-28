abstract class SelectForSignatureBaseModel {
  SelectForSignatureBaseModel({
    required this.id,
    required this.initials,
    required this.shortFullName,
    required this.isValidForSignature,
    required this.signingAbilityStatusInfosList,
    required this.signingAbilityStatusInfos,
  });

  final String id;

  final String initials;

  final String shortFullName;

  final bool isValidForSignature;

  final List<String> signingAbilityStatusInfosList;

  final String signingAbilityStatusInfos;
}
