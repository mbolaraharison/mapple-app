// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormErrorStore<T> on _FormErrorStoreBase<T>, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorStoreBase.hasErrors'))
          .value;
  Computed<bool>? _$hasMultipleErrorsComputed;

  @override
  bool get hasMultipleErrors => (_$hasMultipleErrorsComputed ??= Computed<bool>(
          () => super.hasMultipleErrors,
          name: '_FormErrorStoreBase.hasMultipleErrors'))
      .value;
  Computed<String?>? _$firstErrorComputed;

  @override
  String? get firstError =>
      (_$firstErrorComputed ??= Computed<String?>(() => super.firstError,
              name: '_FormErrorStoreBase.firstError'))
          .value;

  late final _$errorsAtom =
      Atom(name: '_FormErrorStoreBase.errors', context: context);

  @override
  Map<String, String?> get errors {
    _$errorsAtom.reportRead();
    return super.errors;
  }

  @override
  set errors(Map<String, String?> value) {
    _$errorsAtom.reportWrite(value, super.errors, () {
      super.errors = value;
    });
  }

  late final _$_FormErrorStoreBaseActionController =
      ActionController(name: '_FormErrorStoreBase', context: context);

  @override
  void setErrors(Map<String, String?> errors) {
    final _$actionInfo = _$_FormErrorStoreBaseActionController.startAction(
        name: '_FormErrorStoreBase.setErrors');
    try {
      return super.setErrors(errors);
    } finally {
      _$_FormErrorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String key, String? value) {
    final _$actionInfo = _$_FormErrorStoreBaseActionController.startAction(
        name: '_FormErrorStoreBase.setError');
    try {
      return super.setError(key, value);
    } finally {
      _$_FormErrorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrors() {
    final _$actionInfo = _$_FormErrorStoreBaseActionController.startAction(
        name: '_FormErrorStoreBase.resetErrors');
    try {
      return super.resetErrors();
    } finally {
      _$_FormErrorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errors: ${errors},
hasErrors: ${hasErrors},
hasMultipleErrors: ${hasMultipleErrors},
firstError: ${firstError}
    ''';
  }
}
