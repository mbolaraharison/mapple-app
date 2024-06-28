import 'package:google_place/google_place.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'address_autocomplete_form_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AddressAutocompleteFormStoreInterface {
  AddressAutocompleteFormStoreInterface._(
    this.predictions,
    this.isLoading,
    this.manualMode,
  );

  List<AutocompletePrediction> predictions;

  bool isLoading;

  bool manualMode;

  Future<void> search(String query);

  void backToAutoMode(String query);

  Future<AddressDTO?> select(AutocompletePrediction prediction);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AddressAutocompleteFormStore = _AddressAutocompleteFormStore
    with _$AddressAutocompleteFormStore;

abstract class _AddressAutocompleteFormStore
    with Store
    implements AddressAutocompleteFormStoreInterface {
  late final AddressAutocompleteUtilsInterface _addressAutocompleteUtils =
      getIt<AddressAutocompleteUtilsInterface>();

  @override
  @observable
  List<AutocompletePrediction> predictions = [];

  @override
  @observable
  bool isLoading = false;

  @override
  @observable
  bool manualMode = false;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  Future<void> search(String query) async {
    predictions = [];
    if (query.isEmpty) {
      return;
    }
    List<AutocompletePrediction>? result =
        await _addressAutocompleteUtils.search(query);
    if (result == null) {
      result = await _addressAutocompleteUtils.search(query);
      if (result == null) {
        manualMode = true;
        return;
      }
    }
    predictions = result;
    isLoading = false;
  }

  @override
  @action
  void backToAutoMode(String query) {
    manualMode = false;
    search(query);
  }

  @override
  @action
  Future<AddressDTO?> select(AutocompletePrediction prediction) async {
    return await _addressAutocompleteUtils.getDetails(prediction.placeId!);
  }
}
