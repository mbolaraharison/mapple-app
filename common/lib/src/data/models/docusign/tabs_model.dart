import 'package:maple_common/maple_common.dart';

class TabsModel {
  late final List<SignHereTabModel> signHereTabs;

  TabsModel({
    required this.signHereTabs,
  });

  TabsModel.fromJson(Map<String, dynamic> json)
      : signHereTabs = json['signHereTabs'];

  Map<String, dynamic> toJson() => {
        'signHereTabs': signHereTabs.map((e) => e.toJson()).toList(),
      };
}
