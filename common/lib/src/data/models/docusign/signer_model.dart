import 'package:maple_common/maple_common.dart';

class SignerModel {
  late final String clientUserId;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String recipientId;
  late final String routingOrder;
  late final RecipientSmsAuthenticationModel? smsAuthentication;
  late final String status;
  late final TabsModel tabs;
  late final String idCheckConfigurationName;
  late final bool requireIdLookup;

  SignerModel({
    required this.clientUserId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.recipientId,
    required this.routingOrder,
    required this.smsAuthentication,
    required this.status,
    required this.tabs,
    required this.idCheckConfigurationName,
    required this.requireIdLookup,
  });

  SignerModel.fromJson(Map<String, dynamic> json)
      : clientUserId = json['clientUserId'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        name = json['name'],
        recipientId = json['recipientId'],
        routingOrder = json['routingOrder'],
        smsAuthentication = json['smsAuthentication'],
        status = json['status'],
        tabs = json['tabs'],
        idCheckConfigurationName = json['idCheckConfigurationName'],
        requireIdLookup = json['requireIdLookup'];

  Map<String, dynamic> toJson() => {
        'clientUserId': clientUserId,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'name': name,
        'recipientId': recipientId,
        'routingOrder': routingOrder,
        'smsAuthentication': smsAuthentication?.toJson(),
        'status': status,
        'tabs': tabs.toJson(),
        'idCheckConfigurationName': idCheckConfigurationName,
        'requireIdLookup': requireIdLookup,
      };
}
