import 'dart:io';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as path;

part 'signature_step_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SignatureStepStoreInterface {
  SignatureStepStoreInterface._(
    this.envelopeRecipientIds,
    this.envelopeSignedRecipientIds,
    this.contactSigners,
    this.repSigners,
    this.envelopeAlreadySigned,
  );

  // Variables:-----------------------------------------------------------------
  ObservableList<String> envelopeRecipientIds;

  ObservableList<String> envelopeSignedRecipientIds;

  ObservableList<Signer<SignerModel>> contactSigners;

  ObservableList<Signer<SignerModel>> repSigners;

  String? envelopeId;

  File? vatCertificate;

  bool envelopeAlreadySigned;

  // Computed:------------------------------------------------------------------
  int get step;

  bool get haveAllSignersSigned;

  bool get hasEnvelope;

  bool get shouldRecreateEnvelope;

  // Methods:-------------------------------------------------------------------
  Future<void> setEnvelopeId(String? value);

  Future<void> setVatCertificate(File value);

  Future<void> setShouldRecreateEnvelope(bool value);

  Future<void> addRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true});

  Future<void> addSignedRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true});

  Future<void> setTermsDocument(File value);

  Future<void> setSignedByRecipientId(String value, {bool withUpdate = true});

  Future<void> setEnvelopeSignedAt(DateTime value, {bool withUpdate = true});

  Future<void> resetSignatureStep();

  void dispose();
}

// Params:----------------------------------------------------------------------
class SignatureStepStoreParams {
  SignatureStepStoreParams({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SignatureStepStore = _SignatureStepStoreBase with _$SignatureStepStore;

abstract class _SignatureStepStoreBase
    with Store
    implements SignatureStepStoreInterface {
  // Constructor:---------------------------------------------------------------
  _SignatureStepStoreBase({required SignatureStepStoreParams params})
      : customerOrderStore = params.customerOrderStore {
    _onContactsChanged(
        customerOrderStore.finalizationStepStore.selectedContactValues);
    _onRepsChanged(customerOrderStore.finalizationStepStore.selectedReps);

    _disposers = [
      reaction(
        (_) => customerOrderStore.finalizationStepStore.selectedContactValues,
        _onContactsChanged,
      ),
      reaction(
        (_) => customerOrderStore.finalizationStepStore.selectedReps,
        _onRepsChanged,
      ),
    ];

    init();
  }

  // Variables:-----------------------------------------------------------------
  final CustomerOrderStoreInterface customerOrderStore;

  // Dependencies:--------------------------------------------------------------
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();

  // Disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;
  ReactionDisposer? _orderReactionDisposer;

  // Store variables:-----------------------------------------------------------
  @observable
  File? termsDocument;

  @observable
  String? accessToken;

  @override
  @observable
  File? vatCertificate;

  @override
  @observable
  ObservableList<Signer<SignerModel>> contactSigners = ObservableList();

  @override
  @observable
  ObservableList<Signer<SignerModel>> repSigners = ObservableList();

  @override
  @observable
  String? envelopeId;

  @observable
  String? orderFormId;

  @override
  @observable
  bool envelopeAlreadySigned = false;

  @observable
  ObservableList<String> envelopeDocumentIds = ObservableList();

  @override
  @observable
  ObservableList<String> envelopeRecipientIds = ObservableList();

  @override
  @observable
  ObservableList<String> envelopeSignedRecipientIds = ObservableList();

  @observable
  DateTime? envelopeSignedAt;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  int get step => customerOrderStore.order.signatureStep;

  @override
  @computed
  bool get shouldRecreateEnvelope =>
      customerOrderStore.order.shouldRecreateEnvelope;

  @override
  @computed
  bool get hasEnvelope => envelopeId != null && envelopeId != '';

  @override
  @computed
  bool get haveAllSignersSigned =>
      envelopeRecipientIds.isNotEmpty &&
      envelopeRecipientIds.length == envelopeSignedRecipientIds.length;

  @computed
  bool get envelopePartiallySigned =>
      envelopeRecipientIds.isNotEmpty &&
      envelopeSignedRecipientIds.isNotEmpty &&
      envelopeRecipientIds.length != envelopeSignedRecipientIds.length;

  // Actions:-------------------------------------------------------------------
  @action
  void setAccessToken(String? value) {
    accessToken = value;
  }

  @action
  Future<void> init() async {
    await loadData();
    // watch order
    _orderReactionDisposer?.reaction.dispose();
    _orderReactionDisposer = reaction(
      (_) => customerOrderStore.order,
      (Order? order) async {
        await loadData();
      },
    );
  }

  @action
  Future<void> loadData() async {
    envelopeId = customerOrderStore.order.envelopeId;
    orderFormId = customerOrderStore.order.orderFormId;
    envelopeAlreadySigned = customerOrderStore.order.envelopeAlreadySigned;
    envelopeRecipientIds =
        ObservableList.of(customerOrderStore.order.envelopeRecipientIds);
    envelopeSignedRecipientIds =
        ObservableList.of(customerOrderStore.order.envelopeSignedRecipientIds);
    envelopeSignedAt = customerOrderStore.order.envelopeSignedAt;
  }

  @override
  @action
  Future<void> setShouldRecreateEnvelope(bool value) async {
    customerOrderStore.order.shouldRecreateEnvelope = value;

    if (shouldRecreateEnvelope && !envelopeAlreadySigned) {
      if (step == 4) {
        customerOrderStore.order.signatureStep = 3;
      }
      // reset envelope
      await addRecipientIds([], withUpdate: false);
      await addSignedRecipientIds([], withUpdate: false);
    }

    await customerOrderStore.updateOrder();
  }

  @override
  @action
  Future<void> resetSignatureStep() async {
    customerOrderStore.order.shouldRecreateEnvelope = true;
    customerOrderStore.order.cartStatus = CartStatus.finalization;
    customerOrderStore.order.signatureStep = 1;
    // set step and percentage to 3
    customerOrderStore.setStep(3);
    String? termsDocumentFileDataId =
        customerOrderStore.order.termsDocumentFileDataId;
    String? vatCertificateFileDataId =
        customerOrderStore.order.vatCertificateFileDataId;
    customerOrderStore.order.termsDocumentFileDataId = null;
    customerOrderStore.order.vatCertificateFileDataId = null;
    // reset envelope
    await addRecipientIds([], withUpdate: false);
    await addSignedRecipientIds([], withUpdate: false);
    await customerOrderStore.updateOrder();
    // delete documents
    if (termsDocumentFileDataId != null) {
      _fileDataService.deleteById(termsDocumentFileDataId);
    }
    if (vatCertificateFileDataId != null) {
      _fileDataService.deleteById(vatCertificateFileDataId);
    }
  }

  @override
  @action
  Future<void> setEnvelopeId(String? value) async {
    envelopeId = value;
    // update cart
    if (customerOrderStore.order.envelopeId != envelopeId) {
      customerOrderStore.order.envelopeId = envelopeId ?? '';
      await customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  Future<void> setEnvelopeSignedAt(DateTime value,
      {bool withUpdate = true}) async {
    envelopeSignedAt = value;
    // set customer status to READY_FOR_CREATE
    Customer customer = customerOrderStore.order.customer!;
    customer.syncStatus = customer.syncStatus == SyncStatus.NOT_READY
        ? SyncStatus.READY_FOR_CREATE
        : customer.syncStatus;

    await _customerService.update(customer);

    customerOrderStore.order.status = OrderStatus.A;
    customerOrderStore.order.envelopeSignedAt = envelopeSignedAt;
    customerOrderStore.order.syncStatus = SyncStatus.READY_FOR_CREATE;
    if (withUpdate) {
      await customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  Future<void> addRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true}) async {
    if (purgeRecipients) {
      envelopeRecipientIds.clear();
    }

    for (String value in values) {
      envelopeRecipientIds.add(value);
    }
    // update cart
    customerOrderStore.order.envelopeRecipientIds = envelopeRecipientIds;
    if (withUpdate) {
      await customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  Future<void> setSignedByRecipientId(String value,
      {bool withUpdate = true}) async {
    int contactIndex = contactSigners
        .indexWhere((element) => element.signer.recipientId == value);
    if (contactIndex != -1) {
      contactSigners[contactIndex].signed = true;
      // update order later => withUpdate = false
      await addSignedRecipientIds([value],
          purgeRecipients: false, withUpdate: false);
      // Check if all contacts have signed
      if (contactSigners.every((element) => element.signed)) {
        // update order later => withUpdate = false
        await incrementStep(withUpdate: false);
      }
      // update only if withUpdate parameter = true
      if (withUpdate) {
        await customerOrderStore.updateOrder();
      }
      return;
    }
    int repIndex =
        repSigners.indexWhere((element) => element.signer.recipientId == value);
    if (repIndex == -1) {
      return;
    }
    repSigners[repIndex].signed = true;
    await addSignedRecipientIds([value],
        purgeRecipients: false, withUpdate: withUpdate);
  }

  @override
  @action
  Future<void> addSignedRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true}) async {
    if (purgeRecipients) {
      envelopeSignedRecipientIds.clear();
    }

    for (String value in values) {
      envelopeSignedRecipientIds.add(value);
    }

    // update cart
    customerOrderStore.order.envelopeSignedRecipientIds =
        envelopeSignedRecipientIds;

    if (haveAllSignersSigned) {
      envelopeAlreadySigned = true;
      customerOrderStore.order.envelopeAlreadySigned = envelopeAlreadySigned;
    }

    if (withUpdate) {
      await customerOrderStore.updateOrder();
    }
  }

  @action
  Future<void> incrementStep({bool withUpdate = true}) async {
    // update cart
    customerOrderStore.order.signatureStep++;
    if (withUpdate) {
      await customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  Future<void> setTermsDocument(File value) async {
    termsDocument = value;
    String extension = path.extension(value.path);
    String uniqueName =
        'terms-document-${customerOrderStore.order.id}$extension';
    String displayName =
        'terms-document-${customerOrderStore.order.id}$extension';
    Agency currentAgency = (await _agencyService.getCurrent())!;
    // copy file to app directory
    final file = await _fileUtils.save(
      file: value,
      path: await _fileUtils.getUploadPath(
        agencyName: currentAgency.label,
        customerName: customerOrderStore.order.customer!.name,
        fileName: uniqueName,
      ),
    );

    // create file data
    FileData fileData = FileData(
      id: _uuidUtils.generate(),
      uniqueName: uniqueName,
      displayName: displayName,
      existsInStorage: false,
      syncStatus: SyncStatus.NOT_READY,
      mode: FileDataMode.remote,
      agencyId: currentAgency.id,
    );
    await _fileDataService.createAndUpload(fileData, file);

    await customerOrderStore.setTermsDocumentFileDataId(fileData.id);

    if (step == 1) {
      await incrementStep();
    }
  }

  @override
  @action
  Future<void> setVatCertificate(File value) async {
    String extension = path.extension(value.path);
    String uniqueName =
        'vat-certificate-${customerOrderStore.order.id}$extension';

    vatCertificate = value;
    String displayName =
        'vat-certificate-${customerOrderStore.order.id}$extension';
    Agency currentAgency = (await _agencyService.getCurrent())!;
    // copy file to app directory
    final file = await _fileUtils.save(
      file: value,
      path: await _fileUtils.getUploadPath(
        agencyName: currentAgency.label,
        customerName: customerOrderStore.order.customer!.name,
        fileName: uniqueName,
      ),
    );

    if (customerOrderStore.order.vatCertificateFileDataId == null) {
      // Create file data
      FileData fileData = FileData(
        id: _uuidUtils.generate(),
        uniqueName: uniqueName,
        displayName: displayName,
        existsInStorage: false,
        syncStatus: SyncStatus.NOT_READY,
        mode: FileDataMode.remote,
        agencyId: currentAgency.id,
      );

      await _fileDataService.createAndUpload(fileData, file);

      customerOrderStore.order.vatCertificateFileDataId = fileData.id;
    } else {
      FileData? currentFileData =
          customerOrderStore.order.vatCertificateFileData;
      if (currentFileData == null) {
        return;
      }
      // Delete the old file from local storage
      _fileDataService.removeFromFileSystem(currentFileData.uniqueName);

      // Update file data
      currentFileData.uniqueName = uniqueName;
      currentFileData.displayName = displayName;
      currentFileData.existsInStorage = false;
      await _fileDataService.update(currentFileData);

      // Upload the new file
      _fileDataService.tryUpload(file);
    }

    if (step == 2) {
      customerOrderStore.order.signatureStep++;
    }

    await setShouldRecreateEnvelope(true);
  }

  Future<void> _onContactsChanged(List<String> contactIds) async {
    final contacts =
        await customerOrderStore.finalizationStepStore.selectedContacts;
    List<Signer<SignerModel>> fetchedContacts = [];
    contacts.asMap().forEach((index, value) {
      String recipientId = '${index + 1}';
      fetchedContacts.add(contacts[index].getSignerModel(
        index: index,
        withMultipleSigners: contacts.length > 1,
        signed: customerOrderStore.order.envelopeSignedRecipientIds
            .contains(recipientId),
        recipientId: recipientId,
      ));
    });
    contactSigners = ObservableList.of(fetchedContacts);
  }

  void _onRepsChanged(List<Representative> reps) {
    List<Signer<SignerModel>> fetchedReps = [];
    reps.asMap().forEach((index, value) {
      String recipientId = '${index + 11}';
      fetchedReps.add(reps[index].getSignerModel(
        index: index,
        signed: customerOrderStore.order.envelopeSignedRecipientIds
            .contains(recipientId),
        recipientId: recipientId,
      ));
    });
    repSigners = ObservableList.of(fetchedReps);
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    _orderReactionDisposer?.reaction.dispose();
  }
}
