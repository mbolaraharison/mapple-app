import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartSignatureWidgetInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class CartSignatureThemeInterface {
  Color get activeAvatarColor;
}

// Implementation:--------------------------------------------------------------
class CartSignature extends StatefulWidget
    implements CartSignatureWidgetInterface {
  const CartSignature({super.key});

  @override
  State<CartSignature> createState() => _CartSignatureState();
}

class _CartSignatureState extends State<CartSignature>
    with PrivateDirectoryMixin {
  // Stores:--------------------------------------------------------------------
  late final CustomerOrderStoreInterface _customerOrderStore;
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final DocusignServiceInterface _docusignService =
      getIt<DocusignServiceInterface>();
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final FairServiceInterface _fairService = getIt<FairServiceInterface>();

  // Variables:-----------------------------------------------------------------
  late final void Function(dynamic) _showDatesErrorDialog;

  // Services:------------------------------------------------------------------
  final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  final DocusignLogServiceInterface _docusignLogService =
      getIt<DocusignLogServiceInterface>();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();
  late final CartTermsNavigatorInterface _cartTermsNavigator =
      getIt<CartTermsNavigatorInterface>();

  // Utils:---------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final CartSignatureThemeInterface _theme =
      getIt<CartSignatureThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = context.read<CustomerOrderStoreInterface>();
    _showDatesErrorDialog = context.read<void Function(dynamic)>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_customerOrderStore.order.status == OrderStatus.Z &&
          (!_customerOrderStore.finalizationStepStore.isInstallAtUpToDate ||
              !_customerOrderStore
                  .finalizationStepStore.isEndProjectAtUpToDate)) {
        _showDatesErrorDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        List<Signer<SignerModel>> contactAvatars =
            _customerOrderStore.signatureStepStore.contactSigners;
        List<Signer<SignerModel>> representativeAvatars =
            _customerOrderStore.signatureStepStore.repSigners;

        return Column(
          children: [
            Container(
              height: 174,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MapleCommonAssets.cartSignatureBanner),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 36),
            _buildRowButton(
              'cart.accept_the_terms'.tr(),
              step: 1,
              onPressed: () => _openTermsDialog(context),
            ),
            const SizedBox(height: 37),
            _buildRowButton('cart.vat_certificate.title'.tr(),
                step: 2, onPressed: _openVatCertificateDialog),
            const SizedBox(height: 37),
            _buildRowButton(
              'cart.customer_signatures'.tr(),
              step: 3,
              onPressed: () => _openContactSignatoryModalPopupForSigning(
                  'cart.customer_signatures'.tr(),
                  _customerOrderStore.signatureStepStore.contactSigners),
              avatars: contactAvatars,
            ),
            const SizedBox(height: 37),
            _buildRowButton(
              'cart.sales_representatives_signatures'.tr(),
              step: 4,
              onPressed: () => _openRepSignatoryModalPopupForSigning(
                  'cart.sales_representatives_signatures'.tr(),
                  _customerOrderStore.signatureStepStore.repSigners),
              avatars: representativeAvatars,
            ),
          ],
        );
      },
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildRowButton(
    String label, {
    required int step,
    VoidCallback? onPressed,
    List<Signer<SignerModel>> avatars = const [],
    Color? activeAvatarColor,
  }) {
    activeAvatarColor ??= _theme.activeAvatarColor;
    return SizedBox(
      width: 580,
      child: getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          height: 65,
          borderRadius: BorderRadius.circular(8),
          disable: _customerOrderStore.order.isReadonly,
          onPressed: _customerOrderStore.signatureStepStore.step >= step &&
                  !_customerOrderStore.order.isReadonly
              ? onPressed
              : null,
          child: Row(
            children: [
              SvgPicture.asset(
                _customerOrderStore.signatureStepStore.step > step ||
                        _customerOrderStore.order.isReadonly
                    ? MapleCommonAssets.checkCircle
                    : MapleCommonAssets.time,
                width: 35,
              ),
              const SizedBox(width: 18),
              Text(
                label,
                style: TextStyle(
                  color: _customerOrderStore.signatureStepStore.step >= step &&
                          !_customerOrderStore.order.isReadonly
                      ? _appThemeData.defaultTextColor
                      : MapleCommonColors.greyLighter,
                ),
              ),
              const Spacer(),
              _buildAvatars(
                avatars,
                activeAvatarColor: activeAvatarColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatars(List<Signer<SignerModel>> avatars,
      {Color? activeAvatarColor}) {
    activeAvatarColor ??= _theme.activeAvatarColor;
    return Row(
      children: avatars.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: GestureDetector(
            child: getIt<AvatarWidgetInterface>(
              param1: AvatarProps(
                firstLetter: e.initials.substring(0, 1),
                secondLetter:
                    e.initials.length >= 2 ? e.initials.substring(1, 2) : null,
                size: 26,
                fontSize: 12,
                color: _customerOrderStore
                        .signatureStepStore.envelopeSignedRecipientIds
                        .contains(e.signer.recipientId)
                    ? activeAvatarColor
                    : MapleCommonColors.greyLighter.withOpacity(.3),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // General methods:-----------------------------------------------------------
  void _openContactSignatoryModalPopupForSigning(
      String title, List<Signer<SignerModel>> signers) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          getIt<CartSignatureSelectContactForSigningDialogWidgetInterface>(
        param1: CartSignatureSelectContactForSigningDialogProps(
          signers: signers,
          customerOrderStore: _customerOrderStore,
          onSelect: (value) {
            _rootNavigator.key.currentState?.pop();
            Signer<SignerModel>? signer = signers
                .firstWhere((element) => element.signer.recipientId == value);
            _triggerSigning(signer.signer);
          },
        ),
      ),
    );
  }

  void _openRepSignatoryModalPopupForSigning(
      String title, List<Signer<SignerModel>> signers) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          getIt<CartSignatureSelectRepForSigningDialogWidgetInterface>(
        param1: CartSignatureSelectRepForSigningDialogProps(
          signers: signers,
          customerOrderStore: _customerOrderStore,
          onSelect: (value) {
            _rootNavigator.key.currentState?.pop();
            Signer<SignerModel>? signer = signers
                .firstWhere((element) => element.signer.recipientId == value);
            _triggerSigning(signer.signer);
          },
        ),
      ),
    );
  }

  Future<void> _openTermsDialog(BuildContext context) async {
    _loaderUtils.startLoading(context);
    for (int i = 0; i < _customerOrderStore.order.orderRows.length; i++) {
      await _customerOrderStore.order.orderRows[i].loadData(eager: true);
    }
    if (!context.mounted) return;
    await _loaderUtils.stopLoading(context);
    if (!context.mounted) return;
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => Provider<CustomerOrderStoreInterface>(
        create: (_) => _customerOrderStore,
        child: getIt<DialogWrapperWidgetInterface>(
          param1: DialogWrapperProps(
            width: 850,
            height: 560,
            disableContentWrapper: true,
            child: Navigator(
              key: _cartTermsNavigator.key,
              initialRoute: _cartTermsNavigator.acceptTerms,
              onGenerateRoute: _cartTermsNavigator.onGenerateRoute,
            ),
          ),
        ),
      ),
    );
  }

  void _openVatCertificateDialog() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (_) => getIt<VatCertificateDialogWidgetInterface>(
        param1: VatCertificateDialogProps(
          fileData: _customerOrderStore.order.vatCertificateFileData,
          onSubmitted: (File file) async {
            _loaderUtils.startLoading(context);
            await _customerOrderStore.signatureStepStore
                .setVatCertificate(file);
            if (!mounted) return;
            _loaderUtils.stopLoading(context);
          },
        ),
      ),
    );
  }

  Future<void> _generatePdf() async {
    List<Representative> repValues =
        _customerOrderStore.finalizationStepStore.selectedReps.toList();
    await getIt<OrderFormGeneratorInterface>().generate(
      repValues: repValues,
      order: _customerOrderStore.order,
      openFile: false,
    );
  }

  Future<void> _createOrReplaceEnvelope() async {
    Representative? currentRep = await _representativeService.getCurrent();
    if (currentRep?.hasFairAccess == true &&
        _customerOrderStore.order.fairId == null) {
      Fair? fair = await _fairService.getCurrent();
      if (fair != null) {
        await _customerOrderStore.setFairId(fair.id);
      }
    }
    bool envelopeExists = await _docusignService
        .envelopeExists(_customerOrderStore.signatureStepStore.envelopeId);
    // If envelope is already created and should not be recreated -> return
    // If envelope is already signed -> return
    if (envelopeExists &&
        ((_customerOrderStore.signatureStepStore.hasEnvelope &&
                !_customerOrderStore
                    .signatureStepStore.shouldRecreateEnvelope) ||
            _customerOrderStore.signatureStepStore.envelopeAlreadySigned)) {
      return;
    }

    // delete envelope
    if (_customerOrderStore.signatureStepStore.hasEnvelope) {
      await _deleteEnvelope();
    }
    // generate pdf
    await _generatePdf();
    // create envelope
    await _createEnvelope();

    await _customerOrderStore.signatureStepStore
        .setShouldRecreateEnvelope(false);
  }

  Future<void> _deleteEnvelope() async {
    String? result = await _docusignService.deleteEnvelope(
        _customerOrderStore.signatureStepStore.envelopeId ?? '');
    _customerOrderStore.signatureStepStore.envelopeRecipientIds.clear();
    _customerOrderStore.signatureStepStore.envelopeSignedRecipientIds.clear();
    await _customerOrderStore.signatureStepStore.setEnvelopeId(null);
    if (result != null) {
      // save docusign log for deleted envelope
      await _docusignLogService.createLog(
        envelopeId: result,
        orderId: _customerOrderStore.order.id,
        recipientId: '',
        recipientName: 'Docusign Account',
        action: DocusignLogAction.ENVELOPE_DELETED,
        actionLabel: DocusignLogAction.ENVELOPE_DELETED.label,
        actionDescription: DocusignLogAction.ENVELOPE_DELETED.description.tr(),
      );
      if (kDebugMode) {
        print('deleted envelope : $result');
      }
    }
  }

  Future<void> _createEnvelope() async {
    await _customerOrderStore.order.loadData(eager: true);
    for (int i = 0; i < _customerOrderStore.order.orderRows.length; i++) {
      await _customerOrderStore.order.orderRows[i].loadData(eager: true);
    }
    Directory directory = await privateDirectory;
    File file = File(
        '${directory.path}/order-form-${_customerOrderStore.order.id}.pdf');
    List<int> bytes = await file.readAsBytes();
    file.deleteSync();
    String documentId = '1';
    List<String> documentNames = [];

    // documents
    String orderFormName = 'bc.pdf';
    documentNames.add(orderFormName);
    DocumentModel document = DocumentModel(
        documentBase64: base64Encode(bytes),
        documentId: documentId,
        fileExtension: 'pdf',
        includeInDownload: false,
        name: 'bc.pdf');
    List<DocumentModel> documents = [document];

    // signers
    List<SignerModel> signers = [
      ..._customerOrderStore.signatureStepStore.repSigners
          .map((element) => element.signer),
      ..._customerOrderStore.signatureStepStore.contactSigners
          .map((element) => element.signer)
    ];

    // recipients
    RecipientsModel recipients =
        RecipientsModel(carbonCopies: [], signers: signers);

    EnvelopeDefinitionModel body = EnvelopeDefinitionModel(
        documents: documents,
        emailSubject: _customerOrderStore.order.orderFormId,
        recipients: recipients,
        status: 'sent');

    String result = await _docusignService.createEnvelope(body);
    // save signer ids
    await _customerOrderStore.signatureStepStore.addRecipientIds(
        signers.map((e) => e.recipientId).toList(),
        withUpdate: false);
    // set envelope
    await _customerOrderStore.signatureStepStore.setEnvelopeId(result);
    // save docusign log for created envelope
    await _docusignLogService.createLog(
      envelopeId: result,
      orderId: _customerOrderStore.order.id,
      recipientId: '',
      recipientName: 'Docusign Account',
      action: DocusignLogAction.ENVELOPE_CREATED,
      actionLabel: DocusignLogAction.ENVELOPE_CREATED.label,
      actionDescription: DocusignLogAction.ENVELOPE_CREATED.description,
    );
    log('created envelope : $result');
  }

  Future<void> _captiveSigning(SignerModel signerModel) async {
    RecipientViewRequestModel requestViewRequestModel =
        RecipientViewRequestModel(
            authenticationMethod: "None",
            clientUserId: signerModel.clientUserId,
            email: signerModel.email,
            recipientId: signerModel.recipientId,
            returnUrl: "https://docusign.return.url",
            userName: signerModel.name);

    String result = await _docusignService.getRecipientViewUrl(
        _customerOrderStore.signatureStepStore.envelopeId ?? '',
        requestViewRequestModel);

    // show modal
    // ignore: use_build_context_synchronously
    showCupertinoModalPopup(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<WebViewDialogWidgetInterface>(
        param1: WebViewDialogProps(
          initialUrl: result,
          onWebViewCreated: (_) {
            _loaderUtils.stopLoading(context);
          },
          onLoadError: (_, uri, code, message) async {
            // save docusign log for navigation error
            await _docusignLogService.createLog(
              envelopeId:
                  _customerOrderStore.signatureStepStore.envelopeId ?? '',
              orderId: _customerOrderStore.order.id,
              recipientId: signerModel.recipientId,
              recipientName: signerModel.name,
              action: DocusignLogAction.NAVIGATION_ERROR,
              actionLabel: DocusignLogAction.NAVIGATION_ERROR.label,
              actionDescription: uri?.toString() ??
                  DocusignLogAction.NAVIGATION_ERROR.description,
            );
          },
          onUrlChange: (controller, uri) async {
            if (uri == null) return;
            String path = uri.toString();
            bool hasRecipientSignedForTheSession = false;
            bool haveAllRecipientsSigned = false;
            if (path.startsWith('https://docusign.return.url')) {
              // check if all previous signers have signed
              bool havePreviousSignersReallySigned =
                  await _docusignService.haveRecipientsSigned(
                      _customerOrderStore.signatureStepStore.envelopeId ?? '',
                      _customerOrderStore
                          .signatureStepStore.envelopeSignedRecipientIds);
              // check if all signers have signed and the list of signers that have signed is not empty
              if (havePreviousSignersReallySigned == false &&
                  _customerOrderStore.signatureStepStore
                      .envelopeSignedRecipientIds.isNotEmpty) {
                await _customerOrderStore.signatureStepStore
                    .setShouldRecreateEnvelope(true);
                Fluttertoast.showToast(
                  msg: 'cart.signature_error.not_all_signers_have_signed'.tr(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: CupertinoColors.destructiveRed,
                  textColor: CupertinoColors.white,
                  fontSize: 16.0,
                );
              } else {
                if (path.endsWith('event=signing_complete')) {
                  hasRecipientSignedForTheSession =
                      await _docusignService.hasRecipientSigned(
                          _customerOrderStore.signatureStepStore.envelopeId ??
                              '',
                          signerModel.recipientId);
                  if (hasRecipientSignedForTheSession == true) {
                    await _customerOrderStore.signatureStepStore
                        .setSignedByRecipientId(signerModel.recipientId,
                            withUpdate: false);
                  }
                  haveAllRecipientsSigned =
                      await _docusignService.haveRecipientsSigned(
                          _customerOrderStore.signatureStepStore.envelopeId ??
                              '',
                          _customerOrderStore
                              .signatureStepStore.envelopeRecipientIds);
                  // check if all signers have signed
                  if (haveAllRecipientsSigned == true) {
                    await _downloadOrderForm();
                    await _customerOrderStore.signatureStepStore
                        .setEnvelopeSignedAt(DateTime.now(), withUpdate: false);
                    Fluttertoast.showToast(
                      msg: 'cart.success_notification'.tr(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: CupertinoColors.activeGreen,
                      textColor: CupertinoColors.white,
                      fontSize: 16.0,
                    );
                    _customerTabNavigator.key.currentState!.popUntil(
                        ModalRoute.withName(
                            _customerTabNavigator.viewProjectRoute));
                  }
                  // update order
                  if (hasRecipientSignedForTheSession == true) {
                    await _customerOrderStore.updateOrder();
                  }
                }
              }
            }
            // save docusign log for recipient navigation
            await _docusignLogService.createLogWhileOpeningEnvelope(
              envelopeId:
                  _customerOrderStore.signatureStepStore.envelopeId ?? '',
              orderId: _customerOrderStore.order.id,
              recipientId: signerModel.recipientId,
              recipientName: signerModel.name,
              url: path,
              initialUrl: result,
              isSigned: hasRecipientSignedForTheSession,
              isCompleted: haveAllRecipientsSigned,
            );
            if (path.startsWith('https://docusign.return.url') &&
                (_rootNavigator.key.currentState?.canPop() ?? false)) {
              _rootNavigator.key.currentState?.pop();
              // save docusign log for webview closed
              await _docusignLogService.createLog(
                envelopeId:
                    _customerOrderStore.signatureStepStore.envelopeId ?? '',
                orderId: _customerOrderStore.order.id,
                recipientId: signerModel.recipientId,
                recipientName: signerModel.name,
                action: DocusignLogAction.WEBVIEW_CLOSED,
                actionLabel: DocusignLogAction.WEBVIEW_CLOSED.label,
                actionDescription: DocusignLogAction.WEBVIEW_CLOSED.description,
              );
            }
          },
          onWebViewClosed: () async {
            _rootNavigator.key.currentState?.pop();
            // save docusign log for webview closed
            await _docusignLogService.createLog(
              envelopeId:
                  _customerOrderStore.signatureStepStore.envelopeId ?? '',
              orderId: _customerOrderStore.order.id,
              recipientId: signerModel.recipientId,
              recipientName: signerModel.name,
              action: DocusignLogAction.WEBVIEW_CLOSED,
              actionLabel: DocusignLogAction.WEBVIEW_CLOSED.label,
              actionDescription: DocusignLogAction.WEBVIEW_CLOSED.description,
            );
          },
        ),
      ),
    );
  }

  Future<void> _downloadOrderForm() async {
    Agency currentAgency = (await _agencyService.getCurrent())!;

    List<int> bytes = await _docusignService.getEnvelopeDocument(
        _customerOrderStore.signatureStepStore.envelopeId ?? '', '1');
    File file = await _fileUtils.save(
      path: await _fileUtils.getUploadPath(
        agencyName: currentAgency.label,
        customerName: _customerOrderStore.order.customer!.name,
        fileName: 'order-form-${_customerOrderStore.order.id}.pdf',
      ),
    );

    await file.writeAsBytes(bytes);

    String uniqueName = 'order-form-${_customerOrderStore.order.id}.pdf';
    String displayName = '${_customerOrderStore.order.orderFormId}.pdf';
    // create file data
    String fileDataId = _uuidUtils.generate();

    FileData fileData = FileData(
      id: fileDataId,
      uniqueName: uniqueName,
      displayName: displayName,
      existsInStorage: false,
      syncStatus: SyncStatus.READY_FOR_CREATE,
      mode: FileDataMode.remote,
      agencyId: currentAgency.id,
    );
    // save file data
    await _fileDataService.createAndUpload(fileData, file);
    _customerOrderStore.setOrderFormFileDataId(fileDataId, withUpdate: false);
  }

  Future<void> _triggerSigning(SignerModel signer) async {
    try {
      _loaderUtils.startLoading(context);
      // create or replace envelope if necessary
      await _createOrReplaceEnvelope();
      // captive signing
      await _captiveSigning(signer);
    } catch (e, stackTrace) {
      if (mounted) {
        _loaderUtils.stopLoading(context);
      }

      Fluttertoast.showToast(
        msg: e is DtoException
            ? '${'order_form.generate_errors.message'.tr()} $e'
            : 'cart.errors.signature_failed'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: CupertinoColors.destructiveRed,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );

      await FirebaseCrashlytics.instance
          .recordError(e, stackTrace, reason: 'triggerSigning');
      rethrow;
    }
  }
}
