import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_place/google_place.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressAutocompleteForm extends StatefulWidget {
  const AddressAutocompleteForm({
    super.key,
    required this.onSelected,
  });

  final Function(AddressDTO?) onSelected;

  @override
  State<AddressAutocompleteForm> createState() =>
      _AddressAutocompleteFormState();
}

class _AddressAutocompleteFormState extends State<AddressAutocompleteForm> {
  // Variables:-----------------------------------------------------------------
  Timer? _debounce;

  // Stores:--------------------------------------------------------------------
  late final AddressAutocompleteFormStoreInterface _store =
      getIt<AddressAutocompleteFormStoreInterface>();

  // Text controllers:----------------------------------------------------------
  late final TextEditingController _searchController = TextEditingController();

  // Build method:--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (!_store.manualMode) {
        return _buildAutocompleteForm();
      }

      return getIt<AddressManualFormWidgetInterface>(
        param1: AddressManualFormProps(
          address: _searchController.text,
          onSelected: widget.onSelected,
          onBackToAutoMode: _store.backToAutoMode,
        ),
      );
    });
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildAutocompleteForm() {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 15),
        _buildPredictions(),
      ],
    );
  }

  Widget _buildSearchField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        placeholder: 'search'.tr(),
        controller: _searchController,
        onChanged: (value) {
          _store.isLoading = true;
          _debounce?.cancel();
          _debounce = Timer(
            const Duration(milliseconds: 500),
            () => _store.search(value),
          );
        },
      ),
    );
  }

  Widget _buildPredictions() {
    return Observer(
      builder: (_) {
        if (_store.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (_store.predictions.isEmpty) {
          return Container();
        }

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _store.predictions
                .map(
                  (prediction) => _buildSinglePrediction(
                    prediction,
                    _store.predictions.last == prediction,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildSinglePrediction(
      AutocompletePrediction prediction, bool isLast) {
    return GestureDetector(
      onTap: () async {
        AddressDTO? details = await _store.select(prediction);
        widget.onSelected.call(details);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15, bottom: 15, right: 15),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast
                  ? MapleCommonColors.transparent
                  : CupertinoColors.opaqueSeparator,
              width: 0,
            ),
          ),
        ),
        child: Text(prediction.description!),
      ),
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
