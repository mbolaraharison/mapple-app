import 'dart:io';
import 'package:mobx/mobx.dart';

part 'terms_document_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class TermsDocumentDialogStoreInterface {
  // Variables
  File? image;

  // Computed
  bool get isValid;

  // Actions
  void setImage(File? value);
}

// Params:----------------------------------------------------------------------
class TermsDocumentDialogStoreParams {
  TermsDocumentDialogStoreParams({required this.image});

  final File? image;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class TermsDocumentDialogStore = _TermsDocumentDialogStoreBase
    with _$TermsDocumentDialogStore;

abstract class _TermsDocumentDialogStoreBase
    with Store
    implements TermsDocumentDialogStoreInterface {
  _TermsDocumentDialogStoreBase(
      {required TermsDocumentDialogStoreParams params})
      : image = params.image;

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  File? image;

  // Computed:-------------------------------------------------------------------
  @override
  @computed
  bool get isValid => image != null;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setImage(File? value) => image = value;
}
