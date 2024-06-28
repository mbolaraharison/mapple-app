import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'form_error_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class FormErrorStoreInterface {
  Map<String, String?> get errors;
  bool get hasErrors;
  bool get hasMultipleErrors;
  String? get firstError;

  void setErrors(Map<String, String?> errors);
  void setError(String key, String? value);
  void resetErrors();

  void throwIfError();
  void showErrorDialog(String errorMessage, BuildContext context);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class FormErrorStore = _FormErrorStoreBase with _$FormErrorStore;

abstract class _FormErrorStoreBase<T>
    with Store
    implements FormErrorStoreInterface {
  _FormErrorStoreBase(List<String> keys) {
    for (var key in keys) {
      errors[key] = null;
    }
  }

  // Utils:---------------------------------------------------------------------
  late final DialogUtilsInterface _dialogUtils = getIt<DialogUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  Map<String, String?> errors = {};

  // Computeds:-----------------------------------------------------------------
  @override
  @computed
  bool get hasErrors => errors.values.any((element) => element != null);

  @override
  @computed
  bool get hasMultipleErrors =>
      errors.values.where((element) => element != null).length > 1;

  @override
  @computed
  String? get firstError =>
      errors.values.firstWhere((element) => element != null);

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setErrors(Map<String, String?> errors) => this.errors = errors;

  @override
  @action
  void setError(String key, String? value) => errors[key] = value;

  @override
  @action
  void resetErrors() => errors = Map<String, String?>.from(errors.map(
        (key, value) => MapEntry(key, null),
      ));

  // General methods:-----------------------------------------------------------
  @override
  void throwIfError() {
    if (!hasErrors) {
      return;
    }
    String errorMessage =
        hasMultipleErrors ? 'form_multiple_errors'.tr() : firstError!;
    throw ValidationException(errorMessage);
  }

  @override
  void showErrorDialog(String errorMessage, BuildContext context) {
    _dialogUtils.showErrorDialog(context: context, errorMessage: errorMessage);
  }
}
