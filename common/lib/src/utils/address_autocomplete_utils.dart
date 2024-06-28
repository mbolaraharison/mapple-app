import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_place/google_place.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AddressAutocompleteUtilsInterface {
  Future<List<AutocompletePrediction>?> search(String query);

  Future<AddressDTO?> getDetails(String placeId);
}

// Implementation:--------------------------------------------------------------
class AddressAutocompleteUtils implements AddressAutocompleteUtilsInterface {
  late final GooglePlace _googlePlace = getIt<GooglePlace>();

  @override
  Future<List<AutocompletePrediction>?> search(String query) async {
    final AutocompleteResponse? response =
        await _googlePlace.autocomplete.get(query, region: 'fr');
    if (response == null) {
      return null;
    }

    return response.predictions;
  }

  @override
  Future<AddressDTO?> getDetails(String placeId) async {
    final DetailsResponse? response = await _googlePlace.details.get(placeId);
    if (response == null || response.result == null) {
      return null;
    }

    DetailsResult result = response.result!;
    String postalCode = result.addressComponents
            ?.firstWhere(
                (element) => element.types?.contains('postal_code') ?? false)
            .longName ??
        '';
    var city = result.addressComponents
            ?.firstWhere(
                (element) => element.types?.contains('locality') ?? false)
            .longName ??
        '';

    GeoPoint location = GeoPoint(
        result.geometry!.location!.lat!, result.geometry!.location!.lng!);

    var addressDto = AddressDTO(
      address: result.name!,
      postalCode: postalCode,
      city: city,
      location: location,
    );

    return addressDto;
  }
}
