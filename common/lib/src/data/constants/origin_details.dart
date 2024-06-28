// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/data/constants/origin.dart';
import 'package:maple_common/src/domains/ui/types/select_choice.dart';

enum OriginDetails {
  AC('origin_details.previous_customer'), // Previous customer
  BOU('origin_details.word_of_mouth'), // Bouche à oreille
  DEM('origin_details.physical_canvassing'), // Physical canvassing
  DEMT('origin_details.telephone_canvassing'), // Telephone canvassing
  VAG('origin_details.annual_free_visit'), // Annual free visit
  FOE('origin_details.external_fair'), // External Fair
  FOI('origin_details.main_fair'), // Main Fair
  GAL('origin_details.gallery'), // Gallery
  LEAD('origin_details.lead'), // Lead
  MAG('origin_details.shop'), // Shop
  POS('origin_details.direct_mailing'), // Direct mailing
  PUB('origin_details.ads'), // Ads (Media, TV, Radio)
  RAJ('origin_details.fair_addition'), // Fair addition
  RES('origin_details.social_networks'), // Social Networks
  SIT('origin_details.website'); // Website

  const OriginDetails(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<SelectChoice<OriginDetails>> get choices => OriginDetails.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();

  static Map<Origin, List<OriginDetails>> get detailsByOrigin => {
        Origin.COCLI: [
          OriginDetails.BOU,
          OriginDetails.MAG,
          OriginDetails.POS,
          OriginDetails.PUB,
          OriginDetails.RES,
          OriginDetails.SIT,
        ],
        Origin.COCOM: [
          OriginDetails.AC,
          OriginDetails.DEM,
          OriginDetails.DEMT,
          OriginDetails.VAG,
        ],
        Origin.FOIGA: [
          OriginDetails.FOE,
          OriginDetails.FOI,
          OriginDetails.GAL,
          OriginDetails.RAJ,
        ],
        Origin.LEAD: [
          OriginDetails.LEAD,
        ],
      };
}
