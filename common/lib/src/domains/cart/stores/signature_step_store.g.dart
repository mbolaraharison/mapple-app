// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignatureStepStore on _SignatureStepStoreBase, Store {
  Computed<int>? _$stepComputed;

  @override
  int get step => (_$stepComputed ??=
          Computed<int>(() => super.step, name: '_SignatureStepStoreBase.step'))
      .value;
  Computed<bool>? _$shouldRecreateEnvelopeComputed;

  @override
  bool get shouldRecreateEnvelope => (_$shouldRecreateEnvelopeComputed ??=
          Computed<bool>(() => super.shouldRecreateEnvelope,
              name: '_SignatureStepStoreBase.shouldRecreateEnvelope'))
      .value;
  Computed<bool>? _$hasEnvelopeComputed;

  @override
  bool get hasEnvelope =>
      (_$hasEnvelopeComputed ??= Computed<bool>(() => super.hasEnvelope,
              name: '_SignatureStepStoreBase.hasEnvelope'))
          .value;
  Computed<bool>? _$haveAllSignersSignedComputed;

  @override
  bool get haveAllSignersSigned => (_$haveAllSignersSignedComputed ??=
          Computed<bool>(() => super.haveAllSignersSigned,
              name: '_SignatureStepStoreBase.haveAllSignersSigned'))
      .value;
  Computed<bool>? _$envelopePartiallySignedComputed;

  @override
  bool get envelopePartiallySigned => (_$envelopePartiallySignedComputed ??=
          Computed<bool>(() => super.envelopePartiallySigned,
              name: '_SignatureStepStoreBase.envelopePartiallySigned'))
      .value;

  late final _$termsDocumentAtom =
      Atom(name: '_SignatureStepStoreBase.termsDocument', context: context);

  @override
  File? get termsDocument {
    _$termsDocumentAtom.reportRead();
    return super.termsDocument;
  }

  @override
  set termsDocument(File? value) {
    _$termsDocumentAtom.reportWrite(value, super.termsDocument, () {
      super.termsDocument = value;
    });
  }

  late final _$accessTokenAtom =
      Atom(name: '_SignatureStepStoreBase.accessToken', context: context);

  @override
  String? get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String? value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  late final _$vatCertificateAtom =
      Atom(name: '_SignatureStepStoreBase.vatCertificate', context: context);

  @override
  File? get vatCertificate {
    _$vatCertificateAtom.reportRead();
    return super.vatCertificate;
  }

  @override
  set vatCertificate(File? value) {
    _$vatCertificateAtom.reportWrite(value, super.vatCertificate, () {
      super.vatCertificate = value;
    });
  }

  late final _$contactSignersAtom =
      Atom(name: '_SignatureStepStoreBase.contactSigners', context: context);

  @override
  ObservableList<Signer<SignerModel>> get contactSigners {
    _$contactSignersAtom.reportRead();
    return super.contactSigners;
  }

  @override
  set contactSigners(ObservableList<Signer<SignerModel>> value) {
    _$contactSignersAtom.reportWrite(value, super.contactSigners, () {
      super.contactSigners = value;
    });
  }

  late final _$repSignersAtom =
      Atom(name: '_SignatureStepStoreBase.repSigners', context: context);

  @override
  ObservableList<Signer<SignerModel>> get repSigners {
    _$repSignersAtom.reportRead();
    return super.repSigners;
  }

  @override
  set repSigners(ObservableList<Signer<SignerModel>> value) {
    _$repSignersAtom.reportWrite(value, super.repSigners, () {
      super.repSigners = value;
    });
  }

  late final _$envelopeIdAtom =
      Atom(name: '_SignatureStepStoreBase.envelopeId', context: context);

  @override
  String? get envelopeId {
    _$envelopeIdAtom.reportRead();
    return super.envelopeId;
  }

  @override
  set envelopeId(String? value) {
    _$envelopeIdAtom.reportWrite(value, super.envelopeId, () {
      super.envelopeId = value;
    });
  }

  late final _$orderFormIdAtom =
      Atom(name: '_SignatureStepStoreBase.orderFormId', context: context);

  @override
  String? get orderFormId {
    _$orderFormIdAtom.reportRead();
    return super.orderFormId;
  }

  @override
  set orderFormId(String? value) {
    _$orderFormIdAtom.reportWrite(value, super.orderFormId, () {
      super.orderFormId = value;
    });
  }

  late final _$envelopeAlreadySignedAtom = Atom(
      name: '_SignatureStepStoreBase.envelopeAlreadySigned', context: context);

  @override
  bool get envelopeAlreadySigned {
    _$envelopeAlreadySignedAtom.reportRead();
    return super.envelopeAlreadySigned;
  }

  @override
  set envelopeAlreadySigned(bool value) {
    _$envelopeAlreadySignedAtom.reportWrite(value, super.envelopeAlreadySigned,
        () {
      super.envelopeAlreadySigned = value;
    });
  }

  late final _$envelopeDocumentIdsAtom = Atom(
      name: '_SignatureStepStoreBase.envelopeDocumentIds', context: context);

  @override
  ObservableList<String> get envelopeDocumentIds {
    _$envelopeDocumentIdsAtom.reportRead();
    return super.envelopeDocumentIds;
  }

  @override
  set envelopeDocumentIds(ObservableList<String> value) {
    _$envelopeDocumentIdsAtom.reportWrite(value, super.envelopeDocumentIds, () {
      super.envelopeDocumentIds = value;
    });
  }

  late final _$envelopeRecipientIdsAtom = Atom(
      name: '_SignatureStepStoreBase.envelopeRecipientIds', context: context);

  @override
  ObservableList<String> get envelopeRecipientIds {
    _$envelopeRecipientIdsAtom.reportRead();
    return super.envelopeRecipientIds;
  }

  @override
  set envelopeRecipientIds(ObservableList<String> value) {
    _$envelopeRecipientIdsAtom.reportWrite(value, super.envelopeRecipientIds,
        () {
      super.envelopeRecipientIds = value;
    });
  }

  late final _$envelopeSignedRecipientIdsAtom = Atom(
      name: '_SignatureStepStoreBase.envelopeSignedRecipientIds',
      context: context);

  @override
  ObservableList<String> get envelopeSignedRecipientIds {
    _$envelopeSignedRecipientIdsAtom.reportRead();
    return super.envelopeSignedRecipientIds;
  }

  @override
  set envelopeSignedRecipientIds(ObservableList<String> value) {
    _$envelopeSignedRecipientIdsAtom
        .reportWrite(value, super.envelopeSignedRecipientIds, () {
      super.envelopeSignedRecipientIds = value;
    });
  }

  late final _$envelopeSignedAtAtom =
      Atom(name: '_SignatureStepStoreBase.envelopeSignedAt', context: context);

  @override
  DateTime? get envelopeSignedAt {
    _$envelopeSignedAtAtom.reportRead();
    return super.envelopeSignedAt;
  }

  @override
  set envelopeSignedAt(DateTime? value) {
    _$envelopeSignedAtAtom.reportWrite(value, super.envelopeSignedAt, () {
      super.envelopeSignedAt = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_SignatureStepStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_SignatureStepStoreBase.loadData', context: context);

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  late final _$setShouldRecreateEnvelopeAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.setShouldRecreateEnvelope',
      context: context);

  @override
  Future<void> setShouldRecreateEnvelope(bool value) {
    return _$setShouldRecreateEnvelopeAsyncAction
        .run(() => super.setShouldRecreateEnvelope(value));
  }

  late final _$resetSignatureStepAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.resetSignatureStep',
      context: context);

  @override
  Future<void> resetSignatureStep() {
    return _$resetSignatureStepAsyncAction
        .run(() => super.resetSignatureStep());
  }

  late final _$setEnvelopeIdAsyncAction =
      AsyncAction('_SignatureStepStoreBase.setEnvelopeId', context: context);

  @override
  Future<void> setEnvelopeId(String? value) {
    return _$setEnvelopeIdAsyncAction.run(() => super.setEnvelopeId(value));
  }

  late final _$setEnvelopeSignedAtAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.setEnvelopeSignedAt',
      context: context);

  @override
  Future<void> setEnvelopeSignedAt(DateTime value, {bool withUpdate = true}) {
    return _$setEnvelopeSignedAtAsyncAction
        .run(() => super.setEnvelopeSignedAt(value, withUpdate: withUpdate));
  }

  late final _$addRecipientIdsAsyncAction =
      AsyncAction('_SignatureStepStoreBase.addRecipientIds', context: context);

  @override
  Future<void> addRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true}) {
    return _$addRecipientIdsAsyncAction.run(() => super.addRecipientIds(values,
        purgeRecipients: purgeRecipients, withUpdate: withUpdate));
  }

  late final _$setSignedByRecipientIdAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.setSignedByRecipientId',
      context: context);

  @override
  Future<void> setSignedByRecipientId(String value, {bool withUpdate = true}) {
    return _$setSignedByRecipientIdAsyncAction
        .run(() => super.setSignedByRecipientId(value, withUpdate: withUpdate));
  }

  late final _$addSignedRecipientIdsAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.addSignedRecipientIds',
      context: context);

  @override
  Future<void> addSignedRecipientIds(List<String> values,
      {bool purgeRecipients = true, bool withUpdate = true}) {
    return _$addSignedRecipientIdsAsyncAction.run(() => super
        .addSignedRecipientIds(values,
            purgeRecipients: purgeRecipients, withUpdate: withUpdate));
  }

  late final _$incrementStepAsyncAction =
      AsyncAction('_SignatureStepStoreBase.incrementStep', context: context);

  @override
  Future<void> incrementStep({bool withUpdate = true}) {
    return _$incrementStepAsyncAction
        .run(() => super.incrementStep(withUpdate: withUpdate));
  }

  late final _$setTermsDocumentAsyncAction =
      AsyncAction('_SignatureStepStoreBase.setTermsDocument', context: context);

  @override
  Future<void> setTermsDocument(File value) {
    return _$setTermsDocumentAsyncAction
        .run(() => super.setTermsDocument(value));
  }

  late final _$setVatCertificateAsyncAction = AsyncAction(
      '_SignatureStepStoreBase.setVatCertificate',
      context: context);

  @override
  Future<void> setVatCertificate(File value) {
    return _$setVatCertificateAsyncAction
        .run(() => super.setVatCertificate(value));
  }

  late final _$_SignatureStepStoreBaseActionController =
      ActionController(name: '_SignatureStepStoreBase', context: context);

  @override
  void setAccessToken(String? value) {
    final _$actionInfo = _$_SignatureStepStoreBaseActionController.startAction(
        name: '_SignatureStepStoreBase.setAccessToken');
    try {
      return super.setAccessToken(value);
    } finally {
      _$_SignatureStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
termsDocument: ${termsDocument},
accessToken: ${accessToken},
vatCertificate: ${vatCertificate},
contactSigners: ${contactSigners},
repSigners: ${repSigners},
envelopeId: ${envelopeId},
orderFormId: ${orderFormId},
envelopeAlreadySigned: ${envelopeAlreadySigned},
envelopeDocumentIds: ${envelopeDocumentIds},
envelopeRecipientIds: ${envelopeRecipientIds},
envelopeSignedRecipientIds: ${envelopeSignedRecipientIds},
envelopeSignedAt: ${envelopeSignedAt},
step: ${step},
shouldRecreateEnvelope: ${shouldRecreateEnvelope},
hasEnvelope: ${hasEnvelope},
haveAllSignersSigned: ${haveAllSignersSigned},
envelopePartiallySigned: ${envelopePartiallySigned}
    ''';
  }
}
