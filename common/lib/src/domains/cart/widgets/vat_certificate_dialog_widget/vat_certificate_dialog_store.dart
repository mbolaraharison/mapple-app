import 'dart:io';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'vat_certificate_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class VatCertificateDialogStoreInterface {
  VatCertificateDialogStoreInterface._(this.hasBeenSubmitted, this.isLoading);
  // Store variables:-----------------------------------------------------------
  FileData? fileData;
  File? image;
  bool hasBeenSubmitted;
  bool isLoading;

  // Computed:------------------------------------------------------------------
  bool get isValid;

  // Actions:-------------------------------------------------------------------
  void setImage(File? value);
  void setHasBeenSubmitted(bool value);

  // Dispose:-------------------------------------------------------------------
  void dispose();
}

// Params:----------------------------------------------------------------------
class VatCertificateDialogStoreParams {
  final FileData? fileData;

  VatCertificateDialogStoreParams({this.fileData});
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class VatCertificateDialogStore = _VatCertificateDialogStoreBase
    with _$VatCertificateDialogStore;

abstract class _VatCertificateDialogStoreBase
    with Store
    implements VatCertificateDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _VatCertificateDialogStoreBase(
      {required VatCertificateDialogStoreParams params})
      : fileData = params.fileData {
    if (params.fileData != null) {
      _loadFileData(params.fileData!);
    }
  }

  // Store variables:-----------------------------------------------------------
  @override
  FileData? fileData;

  @override
  @observable
  File? image;

  @override
  @observable
  bool hasBeenSubmitted = false;

  @override
  @observable
  bool isLoading = false;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get isValid => image != null;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setImage(File? value) => image = value;

  @override
  @action
  void setHasBeenSubmitted(bool value) => hasBeenSubmitted = value;

  @action
  Future<void> _loadFileData(FileData fileData) async {
    isLoading = true;
    image = await fileData.file;
    isLoading = false;
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    if (image != null) {
      image!.delete();
    }
  }
}
