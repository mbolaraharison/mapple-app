import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_place/google_place.dart';
import 'package:maple_common/maple_common.dart';

final getIt = GetIt.instance;

typedef PreServiceLocatorSetupCallback = Future<void> Function();

class ServiceLocator {
  static Future<void> setupLocator({
    required PreServiceLocatorSetupCallback? preSetupCallback,
  }) async {
    // Pre setup callback
    if (preSetupCallback != null) {
      await preSetupCallback();
    }

    registerSingletonIfNotRegistered<AppInterface>(() => App());
    getIt.registerLazySingleton<GooglePlace>(
        () => GooglePlace(dotenv.env['GOOGLE_API_KEY'] ?? ''));

    // data:--------------------------------------------------------------------

    // data/dao

    // -- data/dao/drift_dao
    getIt.registerLazySingleton<AgencyDriftDao>(
        () => getIt<AgencyDatabase>().agencyDriftDao);
    getIt.registerLazySingleton<ContactDriftDao>(
        () => getIt<AgencyDatabase>().contactDriftDao);
    getIt.registerLazySingleton<CustomerDriftDao>(
        () => getIt<AgencyDatabase>().customerDriftDao);
    getIt.registerLazySingleton<DiscountCodeDriftDao>(
        () => getIt<AgencyDatabase>().discountCodeDriftDao);
    getIt.registerLazySingleton<DiscountCodeServiceDriftDao>(
        () => getIt<AgencyDatabase>().discountCodeServiceDriftDao);
    getIt.registerLazySingleton<DiscountCodeServiceFamilyDriftDao>(
        () => getIt<AgencyDatabase>().discountCodeServiceFamilyDriftDao);
    getIt.registerLazySingleton<DiscountCodeServiceSubFamilyDriftDao>(
        () => getIt<AgencyDatabase>().discountCodeServiceSubFamilyDriftDao);
    getIt.registerLazySingleton<EmailTemplateDriftDao>(
        () => getIt<AgencyDatabase>().emailTemplateDriftDao);
    getIt.registerLazySingleton<FairDriftDao>(
        () => getIt<AgencyDatabase>().fairDriftDao);
    getIt.registerLazySingleton<FileDataDriftDao>(
        () => getIt<AgencyDatabase>().fileDataDriftDao);
    getIt.registerLazySingleton<FileDataFamilyDriftDao>(
        () => getIt<AgencyDatabase>().fileDataFamilyDriftDao);
    getIt.registerLazySingleton<NoteDriftDao>(
        () => getIt<AgencyDatabase>().noteDriftDao);
    getIt.registerLazySingleton<OrderDriftDao>(
        () => getIt<AgencyDatabase>().orderDriftDao);
    getIt.registerLazySingleton<OrderContactDriftDao>(
        () => getIt<AgencyDatabase>().orderContactDriftDao);
    getIt.registerLazySingleton<OrderRowDriftDao>(
        () => getIt<AgencyDatabase>().orderRowDriftDao);
    getIt.registerLazySingleton<PriceListDriftDao>(
        () => getIt<AgencyDatabase>().priceListDriftDao);
    getIt.registerLazySingleton<PriceListItemDriftDao>(
        () => getIt<AgencyDatabase>().priceListItemDriftDao);
    getIt.registerLazySingleton<RepresentativeDriftDao>(
        () => getIt<AgencyDatabase>().representativeDriftDao);
    getIt.registerLazySingleton<ServiceDriftDao>(
        () => getIt<AgencyDatabase>().serviceDriftDao);
    getIt.registerLazySingleton<ServiceFamilyDriftDao>(
        () => getIt<AgencyDatabase>().serviceFamilyDriftDao);
    getIt.registerLazySingleton<ServiceOptionDriftDao>(
        () => getIt<AgencyDatabase>().serviceOptionDriftDao);
    getIt.registerLazySingleton<ServiceOptionItemDriftDao>(
        () => getIt<AgencyDatabase>().serviceOptionItemDriftDao);
    getIt.registerLazySingleton<ServiceSubFamilyDriftDao>(
        () => getIt<AgencyDatabase>().serviceSubFamilyDriftDao);
    getIt.registerLazySingleton<SupplierDriftDao>(
        () => getIt<AgencyDatabase>().supplierDriftDao);
    getIt.registerLazySingleton<UserSettingDriftDao>(
        () => getIt<AgencyDatabase>().userSettingDriftDao);

    // -- data/dao/firestore_dao
    getIt.registerSingleton(RepresentativeFirestoreDao());
    getIt.registerSingleton(RepresentativeAppraisalFirestoreDao());
    getIt.registerSingleton(AgencyFirestoreDao());
    getIt.registerSingleton(FairFirestoreDao());
    getIt.registerSingleton(CustomerFirestoreDao());
    getIt.registerSingleton(ContactFirestoreDao());
    getIt.registerSingleton(DocusignLogFirestoreDao());
    getIt.registerSingleton(EmailFirestoreDao());
    getIt.registerSingleton(EmailTemplateFirestoreDao());
    getIt.registerSingleton(FileDataFamilyFirestoreDao());
    getIt.registerSingleton(FileDataFirestoreDao());
    getIt.registerSingleton(IntegrityJobFirestoreDao());
    getIt.registerSingleton(OrderFirestoreDao());
    getIt.registerSingleton(OrderRowFirestoreDao());
    getIt.registerSingleton(NoteFirestoreDao());
    getIt.registerSingleton(NotificationTokenFirestoreDao());
    getIt.registerSingleton(ServiceFamilyFirestoreDao());
    getIt.registerSingleton(ServiceSubFamilyFirestoreDao());
    getIt.registerSingleton(ServiceFirestoreDao());
    getIt.registerSingleton(ServiceOptionFirestoreDao());
    getIt.registerSingleton(ServiceOptionItemFirestoreDao());
    getIt.registerSingleton(SupplierFirestoreDao());
    getIt.registerSingleton(DiscountCodeFirestoreDao());
    getIt.registerSingleton(PriceListFirestoreDao());
    getIt.registerSingleton(PriceListItemFirestoreDao());
    getIt.registerSingleton(SiteSheetFirestoreDao());
    getIt.registerSingleton(UserSettingFirestoreDao());

    // data/databases
    getIt.registerSingletonAsync<AgencyDatabase>(
        () => AgencyDatabase.createDatabase());
    getIt.registerLazySingletonAsync<AppDatabase>(
        () => AppDatabase.createDatabase());

    // domains:-----------------------------------------------------------------

    // domains/account

    // -- domains/account/navigators
    registerSingletonIfNotRegistered<AccountDialogNavigatorInterface>(
        () => AccountDialogNavigator());
    registerSingletonIfNotRegistered<SyncNavigatorInterface>(
        () => SyncNavigator());

    // -- domains/account/stores
    registerFactoryIfNotRegistered<AccountDialogStoreInterface>(
        () => AccountDialogStore());

    // -- domains/account/widgets
    registerFactoryIfNotRegistered<AccountAboutWidgetInterface>(
        () => const AccountAbout());
    registerFactoryIfNotRegistered<AccountDialogWidgetInterface>(
        () => const AccountDialog());
    registerFactoryIfNotRegistered<AccountHomeWidgetInterface>(
        () => const AccountHome());
    registerFactoryIfNotRegistered<AccountInfosWidgetInterface>(
        () => const AccountInfos());
    registerFactoryIfNotRegistered<AccountSelectFairWidgetInterface>(
        () => const AccountSelectFair());
    registerFactoryIfNotRegistered<SyncErrorWidgetInterface>(
        () => SyncErrorWidget());

    // -- domains/account/widgets/account_reset_password_widget
    registerFactoryIfNotRegistered<AccountResetPasswordStoreInterface>(
        () => AccountResetPasswordStore());
    registerFactoryIfNotRegistered<AccountResetPasswordWidgetInterface>(
        () => const AccountResetPassword());

    // -- domains/account/widgets/select_agency_widget
    registerFactoryIfNotRegistered<SelectAgencyStoreInterface>(
        () => SelectAgencyStore());
    registerFactoryIfNotRegistered<SelectAgencyWidgetInterface>(
        () => const SelectAgency());

    // domains/appraisal

    // -- domains/appraisal/navigators
    registerSingletonIfNotRegistered<AppraisalsNavigatorInterface>(
        () => AppraisalsNavigator());
    registerSingletonIfNotRegistered<
            AddRepresentativeAppraisalNavigatorInterface>(
        () => AddRepresentativeAppraisalNavigator());

    // -- domains/appraisal/widgets/add_representative_appraisal_dialog_widget
    registerFactoryParamIfNotRegistered<
            AddRepresentativeAppraisalDialogWidgetInterface,
            AddRepresentativeAppraisalDialogProps,
            void>(
        (param1, param2) => AddRepresentativeAppraisalDialog(props: param1));
    registerFactoryIfNotRegistered<
            AddRepresentativeAppraisalDialogStoreInterface>(
        () => AddRepresentativeAppraisalDialogStore());
    registerFactoryIfNotRegistered<
            AddRepresentativeAppraisalHomeWidgetInterface>(
        () => const AddRepresentativeAppraisalHome());
    registerFactoryIfNotRegistered<
            AddRepresentativeAppraisalSelectTypeWidgetInterface>(
        () => const AddRepresentativeAppraisalSelectType());

    // -- domains/appraisal/widgets/badge_dialog_widget
    registerFactoryParamIfNotRegistered<BadgeDialogWidgetInterface,
        BadgeDialogProps, void>((param1, param2) => BadgeDialog(props: param1));

    // ---- domains/appraisal/widgets/configure_representative_appraisal_widget
    registerFactoryParamIfNotRegistered<
            ConfigureRepresentativeAppraisalDialogStoreInterface,
            ConfigureRepresentativeAppraisalDialogStoreParams,
            void>(
        (param1, param2) =>
            ConfigureRepresentativeAppraisalDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
            ConfigureRepresentativeAppraisalDialogWidgetInterface,
            Representative,
            void>(
        (param1, param2) =>
            ConfigureRepresentativeAppraisalDialog(representative: param1));

    // ---- domains/appraisal/widgets/representative_appraisal_recall_dialog_widget
    registerFactoryParamIfNotRegistered<
            RepresentativeAppraisalRecallDialogWidgetInterface,
            RepresentativeAppraisalRecallDialogProps,
            void>(
        (param1, param2) => RepresentativeAppraisalRecallDialog(props: param1));
    registerFactoryIfNotRegistered<
            RepresentativeAppraisalRecallDialogStoreInterface>(
        () => RepresentativeAppraisalRecallDialogStore());

    // -- domains/appraisal/widgets
    registerFactoryParamIfNotRegistered<
        DirectorAppraisalsHistoryViewWidgetInterface,
        DirectorAppraisalsHistoryViewProps,
        void>((param1, param2) => DirectorAppraisalsHistoryView(props: param1));
    registerFactoryParamIfNotRegistered<
        DirectorAppraisalsListViewWidgetInterface,
        DirectorAppraisalsListViewProps,
        void>((param1, param2) => DirectorAppraisalsListView(props: param1));
    registerFactoryParamIfNotRegistered<
        RepresentativesListViewWidgetInterface,
        RepresentativesListViewProps,
        void>((param1, param2) => RepresentativesListView(props: param1));

    // -- domains/appraisal/utils
    registerSingletonIfNotRegistered<
            RepresentativeAppraisalFormGeneratorInterface>(
        () => RepresentativeAppraisalFormGenerator());

    // domains/auth

    // -- domains/auth/widgets

    // ---- domains/auth/widgets/reset_password_dialog
    registerFactoryIfNotRegistered<ResetPasswordDialogStoreInterface>(
        () => ResetPasswordDialogStore());
    registerFactoryIfNotRegistered<ResetPasswordDialogWidgetInterface>(
        () => ResetPasswordDialog());

    // domains/cart

    // -- domains/cart/navigators
    registerSingletonIfNotRegistered<CartNavigatorInterface>(
        () => CartNavigator());
    registerSingletonIfNotRegistered<
            CartAddSelectSignatoryDialogNavigatorInterface>(
        () => CartAddSelectSignatoryDialogNavigator());
    registerSingletonIfNotRegistered<CartTermsNavigatorInterface>(
        () => CartTermsNavigator());

    // -- domains/cart/stores
    registerFactoryParamIfNotRegistered<
        CustomerOrderStoreInterface,
        CustomerOrderStoreParams,
        void>((param1, param2) => CustomerOrderStore(params: param1));
    registerFactoryParamIfNotRegistered<
        FinalizationStepStoreInterface,
        FinalizationStepStoreParams,
        void>((param1, param2) => FinalizationStepStore(params: param1));
    registerFactoryParamIfNotRegistered<
        OrderStepStoreInterface,
        OrderStepStoreParams,
        void>((param1, param2) => OrderStepStore(params: param1));
    registerFactoryParamIfNotRegistered<
        PaymentStepStoreInterface,
        PaymentStepStoreParams,
        void>((param1, param2) => PaymentStepStore(params: param1));
    registerFactoryParamIfNotRegistered<
        SignatureStepStoreInterface,
        SignatureStepStoreParams,
        void>((param1, param2) => SignatureStepStore(params: param1));

    // -- domains/cart/utils
    registerSingletonIfNotRegistered<OrderFormGeneratorInterface>(
        () => OrderFormGenerator());

    // -- domains/cart/widgets
    registerFactoryParamIfNotRegistered<
        CartAddSelectSignatoryDialogWidgetInterface,
        CartAddSelectSignatoryDialogProps,
        void>((param1, param2) => CartAddSelectSignatoryDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        CartFinalizationAddRepDialogWidgetInterface,
        CartFinalizationAddRepDialogProps,
        void>((param1, param2) => CartFinalizationAddRepDialog(props: param1));
    registerFactoryIfNotRegistered<CartFinalizationWidgetInterface>(
        () => const CartFinalization());
    registerFactoryIfNotRegistered<CartOrderWidgetInterface>(
        () => const CartOrder());
    registerFactoryIfNotRegistered<CartPaymentWidgetInterface>(
        () => const CartPayment());
    registerFactoryParamIfNotRegistered<
            CartSignatureSelectContactForSigningDialogWidgetInterface,
            CartSignatureSelectContactForSigningDialogProps,
            void>(
        (param1, param2) =>
            CartSignatureSelectContactForSigningDialog(props: param1));
    registerFactoryParamIfNotRegistered<
            CartSignatureSelectRepForSigningDialogWidgetInterface,
            CartSignatureSelectRepForSigningDialogProps,
            void>(
        (param1, param2) =>
            CartSignatureSelectRepForSigningDialog(props: param1));
    registerFactoryIfNotRegistered<CartSignatureWidgetInterface>(
        () => const CartSignature());
    registerFactoryParamIfNotRegistered<
        SendQuoteDialogWidgetInterface,
        SendQuoteDialogProps,
        void>((param1, param2) => SendQuoteDialog(props: param1));

    registerFactoryParamIfNotRegistered<
        ReloadOrderRowPricesDialogWidgetInterface,
        ReloadOrderRowPricesDialogProps,
        void>((param1, param2) => ReloadOrderRowPricesDialog(props: param1));

    // ---- domains/cart/widgets/cart_finalization_add_contact_dialog
    registerFactoryParamIfNotRegistered<
            CartFinalizationAddContactDialogWidgetInterface,
            CartFinalizationAddContactDialogProps,
            void>(
        (param1, param2) => CartFinalizationAddContactDialog(props: param1));
    registerFactoryIfNotRegistered<CartSelectSignatoryWidgetInterface>(
        () => const CartSelectSignatory());
    registerFactoryParamIfNotRegistered<
        CartCreateOrEditContactWidgetInterface,
        CartCreateOrEditContactArguments,
        void>((param1, param2) => CartCreateOrEditContact(arguments: param1));

    // ---- domains/cart/widgets/discount_dialog_widget
    registerFactoryIfNotRegistered<DiscountDialogStoreInterface>(
        () => DiscountDialogStore());
    registerFactoryIfNotRegistered<DiscountDialogWidgetInterface>(
        () => const DiscountDialog());

    // ---- domains/cart/widgets/supplier_dialog_widget
    registerFactoryIfNotRegistered<SuppliersDialogStoreInterface>(
        () => SuppliersDialogStore());
    registerFactoryParamIfNotRegistered<
        SuppliersDialogWidgetInterface,
        SuppliersDialogProps,
        void>((param1, param2) => SuppliersDialog(props: param1));

    // ---- domains/cart/widgets/supplier_dialog_widget/service_with_supplier_widget
    registerFactoryParamIfNotRegistered<
        ServiceWithSupplierStoreInterface,
        ServiceWithSupplierStoreParams,
        void>((param1, param2) => ServiceWithSupplierStore(params: param1));
    registerFactoryParamIfNotRegistered<
        ServiceWithSupplierWidgetInterface,
        ServiceWithSupplierProps,
        void>((param1, param2) => ServiceWithSupplier(props: param1));

    // ---- domains/cart/widgets/supplier_dialog_widget/service_with_supplier_widget/select_supplier_widget
    registerFactoryParamIfNotRegistered<
        SelectSupplierDialogStoreInterface,
        SelectSupplierDialogStoreParams,
        void>((param1, param2) => SelectSupplierDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        SelectSupplierDialogWidgetInterface,
        SelectSupplierDialogProps,
        void>((param1, param2) => SelectSupplierDialog(props: param1));

    // ---- domains/cart/widgets/terms_dialog_widget
    registerFactoryIfNotRegistered<TermsDialogStoreInterface>(
        () => TermsDialogStore());
    registerFactoryIfNotRegistered<TermsDialogWidgetInterface>(
        () => const TermsDialog());

    // ---- domains/cart/widgets/terms_document_dialog_widget
    registerFactoryParamIfNotRegistered<
        TermsDocumentDialogStoreInterface,
        TermsDocumentDialogStoreParams,
        void>((param1, param2) => TermsDocumentDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        TermsDocumentDialogWidgetInterface,
        TermsDocumentDialogProps,
        void>((param1, param2) => TermsDocumentDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        TermsDocumentPadSignWidgetInterface,
        TermsDocumentPadSignProps,
        void>((param1, param2) => TermsDocumentPadSign(props: param1));
    registerFactoryParamIfNotRegistered<
            TermsSelectSignatureMethodWidgetInterface,
            TermsSelectSignatureMethodArguments,
            void>(
        (param1, param2) => TermsSelectSignatureMethod(arguments: param1));

    // ---- domains/cart/widgets/vat_certificate_dialog_widget
    registerFactoryParamIfNotRegistered<
        VatCertificateDialogStoreInterface,
        VatCertificateDialogStoreParams,
        void>((param1, param2) => VatCertificateDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        VatCertificateDialogWidgetInterface,
        VatCertificateDialogProps,
        void>((param1, param2) => VatCertificateDialog(props: param1));

    // domains/customer

    // -- domains/customer/navigators
    registerSingletonIfNotRegistered<CustomerTabNavigatorInterface>(
        () => CustomerTabNavigator());
    registerSingletonIfNotRegistered<EditCustomerDialogNavigatorInterface>(
        () => EditCustomerDialogNavigator());

    // -- domains/customer/utils
    registerSingletonIfNotRegistered<SiteSheetGeneratorInterface>(
        () => SiteSheetGenerator());

    // -- domains/customer/widgets
    registerFactoryParamIfNotRegistered<
        AddEditContactDialogWidgetInterface,
        AddEditContactDialogProps,
        void>((param1, param2) => AddEditContactDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        CustomersProjectCardWidgetInterface,
        CustomersProjectCardProps,
        void>((param1, param2) => CustomersProjectCard(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectCustomerSignatoriesWidgetInterface,
        SelectCustomerSignatoriesProps,
        void>((param1, param2) => SelectCustomerSignatories(props: param1));

    // ---- domains/customer/widgets/contact_form_widget
    registerFactoryParamIfNotRegistered<
        ContactFormStoreInterface,
        ContactFormStoreParams?,
        void>((param1, param2) => ContactFormStore(params: param1));
    registerFactoryParamIfNotRegistered<ContactFormWidgetInterface,
        ContactFormProps, void>((param1, param2) => ContactForm(props: param1));

    // ---- domains/customer/widgets/customer_file_card_widget
    registerFactoryParamIfNotRegistered<
        CustomerFileCardWidgetInterface,
        CustomerFileCardProps,
        void>((param1, param2) => CustomerFileCard(props: param1));

    // ---- domains/customer/widgets/customers_list_view_widget
    registerFactoryParamIfNotRegistered<
        CustomersListViewStoreInterface,
        CustomersListViewStoreParams,
        void>((param1, param2) => CustomersListViewStore(params: param1));
    registerFactoryParamIfNotRegistered<
        CustomersListViewWidgetInterface,
        CustomersListViewProps,
        void>((param1, param2) => CustomersListView(props: param1));

    // ---- domains/customer/widgets/customers_map_view_widget
    registerFactoryIfNotRegistered<CustomersMapViewStoreInterface>(
        () => CustomersMapViewStore());
    registerFactoryIfNotRegistered<CustomersMapViewWidgetInterface>(
        () => const CustomersMapView());

    // ---- domains/customer/widgets/edit_customer_dialog_widget
    registerFactoryParamIfNotRegistered<
        EditCustomerDialogStoreInterface,
        EditCustomerDialogStoreParams,
        void>((param1, param2) => EditCustomerDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        EditCustomerDialogWidgetInterface,
        EditCustomerDialogProps,
        void>((param1, param2) => EditCustomerDialog(props: param1));
    registerFactoryIfNotRegistered<EditCustomerInfosWidgetInterface>(
        () => const EditCustomerInfos());
    registerFactoryIfNotRegistered<EditCustomerSelectOriginWidgetInterface>(
        () => const EditCustomerSelectOrigin());
    registerFactoryIfNotRegistered<EditCustomerSelectTypeWidgetInterface>(
        () => const EditCustomerSelectType());

    // ---- domains/customer/widgets/manage_note_dialog_widget
    registerFactoryParamIfNotRegistered<
        ManageNoteDialogStoreInterface,
        ManageNoteDialogStoreParams,
        void>((param1, param2) => ManageNoteDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        ManageNoteDialogWidgetInterface,
        ManageNoteDialogProps,
        void>((param1, param2) => ManageNoteDialog(props: param1));

    // ---- domains/customer/widgets/site_sheet
    registerFactoryParamIfNotRegistered<CommentsTabWidgetInterface,
        CommentsTabProps, void>((param1, param2) => CommentsTab(props: param1));
    registerFactoryParamIfNotRegistered<
        ConnectionTabWidgetInterface,
        ConnectionTabProps,
        void>((param1, param2) => ConnectionTab(props: param1));
    registerFactoryParamIfNotRegistered<CoverTabWidgetInterface, CoverTabProps,
        void>((param1, param2) => CoverTab(props: param1));
    registerFactoryParamIfNotRegistered<
        DrawingAreaDialogWidgetInterface,
        DrawingAreaDialogProps,
        void>((param1, param2) => DrawingAreaDialog(props: param1));
    registerFactoryParamIfNotRegistered<ExposureTabWidgetInterface,
        ExposureTabProps, void>((param1, param2) => ExposureTab(props: param1));
    registerFactoryParamIfNotRegistered<FacadeTabWidgetInterface,
        FacadeTabProps, void>((param1, param2) => FacadeTab(props: param1));
    registerFactoryParamIfNotRegistered<
        FasciaBoardTabWidgetInterface,
        FasciaBoardTabProps,
        void>((param1, param2) => FasciaBoardTab(props: param1));
    registerFactoryParamIfNotRegistered<GutterTabWidgetInterface,
        GutterTabProps, void>((param1, param2) => GutterTab(props: param1));
    registerFactoryParamIfNotRegistered<
        InsulationTabWidgetInterface,
        InsulationTabProps,
        void>((param1, param2) => InsulationTab(props: param1));
    registerFactoryParamIfNotRegistered<RoofTabWidgetInterface, RoofTabProps,
        void>((param1, param2) => RoofTab(props: param1));
    registerFactoryParamIfNotRegistered<
        StatementOfInformationTabWidgetInterface,
        StatementOfInformationTabProps,
        void>((param1, param2) => StatementOfInformationTab(props: param1));
    registerFactoryParamIfNotRegistered<
        WoodTreatmentTabWidgetInterface,
        WoodTreatmentTabProps,
        void>((param1, param2) => WoodTreatmentTab(props: param1));

    // domains/discount_code

    // -- domains/discount_code/widgets

    // ---- domains/discount_code/widgets/save_discount_code_dialog
    registerFactoryIfNotRegistered<SaveDiscountCodeDialogStoreInterface>(
        () => SaveDiscountCodeDialogStore());
    registerFactoryParamIfNotRegistered<
        SaveDiscountCodeDialogWidgetInterface,
        DiscountCode?,
        void>((param1, param2) => SaveDiscountCodeDialog(discountCode: param1));

    // domains/home

    // -- domains/home/navigators
    registerSingletonIfNotRegistered<HomeTabNavigatorInterface>(
        () => HomeTabNavigator());

    // domains/media

    // -- domains/media/widgets

    // ---- domains/media/widgets/media_card_widget
    registerFactoryParamIfNotRegistered<MediaCardWidgetInterface,
        MediaCardProps, void>((param1, param2) => MediaCard(props: param1));

    // domains/pdf

    // -- domains/pdf/widgets
    registerFactoryParamIfNotRegistered<PdfBannerWidgetInterface,
        PdfBannerProps, void>((param1, param2) => PdfBanner(props: param1));
    registerFactoryParamIfNotRegistered<PdfCheckboxWidgetInterface,
        PdfCheckboxProps, void>((param1, param2) => PdfCheckbox(props: param1));
    registerFactoryParamIfNotRegistered<
        PdfDateFieldWidgetInterface,
        PdfDateFieldProps,
        void>((param1, param2) => PdfDateField(props: param1));
    registerFactoryParamIfNotRegistered<
        PdfDottedLineWidgetInterface,
        PdfDottedLineProps?,
        void>((param1, param2) => PdfDottedLine(props: param1));
    registerFactoryParamIfNotRegistered<PdfSelectWidgetInterface,
        PdfSelectProps, void>((param1, param2) => PdfSelect(props: param1));
    registerFactoryParamIfNotRegistered<
        PdfTextFieldWidgetInterface,
        PdfTextFieldProps,
        void>((param1, param2) => PdfTextField(props: param1));

    // domains/project

    // domains/project/navigators
    registerSingletonIfNotRegistered<AddEditProjectNavigatorInterface>(
        () => AddEditProjectNavigator());
    registerSingletonIfNotRegistered<CreateProjectNavigatorInterface>(
        () => CreateProjectNavigator());

    // -- domains/project/stores
    registerFactoryParamIfNotRegistered<
        AddEditProjectDialogStoreInterface,
        AddEditProjectDialogStoreParams,
        void>((param1, param2) => AddEditProjectDialogStore(params: param1));
    registerFactoryIfNotRegistered<CreateProjectDialogStoreInterface>(
        () => CreateProjectDialogStore());

    // -- domains/project/widgets
    registerFactoryParamIfNotRegistered<AddressWidgetInterface, AddressProps,
        void>((param1, param2) => Address(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDocumentToOpenWidgetInterface,
        SelectDocumentToOpenProps,
        void>((param1, param2) => SelectDocumentToOpen(props: param1));

    // ---- domains/project/widgets/add_edit_project_dialog
    registerFactoryParamIfNotRegistered<
        AddEditProjectDialogWidgetInterface,
        AddEditProjectDialogProps,
        void>((param1, param2) => AddEditProjectDialog(props: param1));
    registerFactoryIfNotRegistered<AddEditProjectInfosWidgetInterface>(
        () => const AddEditProjectInfos());
    registerFactoryIfNotRegistered<
            AddEditProjectSelectMeetingOriginWidgetInterface>(
        () => const AddEditProjectSelectMeetingOrigin());

    // ---- domains/project/widgets/create_project_dialog_widget
    registerFactoryIfNotRegistered<AddEditContactWidgetInterface>(
        () => const AddEditContact());
    registerFactoryIfNotRegistered<ContactsListWidgetInterface>(
        () => const ContactsList());
    registerFactoryIfNotRegistered<CreateCustomerWidgetInterface>(
        () => const CreateCustomer());
    registerFactoryIfNotRegistered<ConfirmDuplicateWidgetInterface>(
        () => const ConfirmDuplicate());
    registerFactoryParamIfNotRegistered<
        CreateProjectDialogTitleWidgetInterface,
        CreateProjectDialogTitleProps,
        void>((param1, param2) => CreateProjectDialogTitle(props: param1));
    registerFactoryParamIfNotRegistered<
        CreateProjectDialogWidgetInterface,
        CreateProjectDialogProps,
        void>((param1, param2) => CreateProjectDialog(props: param1));
    registerFactoryIfNotRegistered<HowFindUsWidgetInterface>(
        () => const HowFindUs());
    registerFactoryIfNotRegistered<SelectTypeWidgetInterface>(
        () => const SelectType());

    // domains/services

    // -- domains/services/widgets
    registerFactoryParamIfNotRegistered<
        ServicesFloatingButtonsWidgetInterface,
        ServicesFloatingButtonsProps,
        void>((param1, param2) => ServicesFloatingButtons(props: param1));

    // ---- domains/services/widgets/services_browser_widget
    registerFactoryParamIfNotRegistered<
        ServicesBrowserWidgetInterface,
        ServicesBrowserProps,
        void>((param1, param2) => ServicesBrowser(props: param1));
    registerFactoryIfNotRegistered<ServicesBrowserStoreInterface>(
        () => ServicesBrowserStore());

    // ---- domains/services/widgets/services_search_widget
    registerFactoryParamIfNotRegistered<
        ServicesSearchWidgetInterface,
        ServicesSearchProps,
        void>((param1, param2) => ServicesSearch(props: param1));
    registerFactoryIfNotRegistered<ServicesSearchStoreInterface>(
        () => ServicesSearchStore());

    // ---- domains/services/widgets/service_dialog_widget
    registerFactoryParamIfNotRegistered<
        ServiceDialogStoreInterface,
        ServiceDialogStoreParams,
        void>((param1, param2) => ServiceDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        ServiceDialogWidgetInterface,
        ServiceDialogProps,
        void>((param1, param2) => ServiceDialog(props: param1));

    // domains/ui

    // -- domains/ui/widgets
    registerFactoryParamIfNotRegistered<AvatarWidgetInterface, AvatarProps,
        void>((param1, param2) => Avatar(props: param1));
    registerFactoryParamIfNotRegistered<CardWidgetInterface, CardProps, void>(
        (param1, param2) => Card(props: param1));
    registerFactoryIfNotRegistered<CustomProgressIndicatorWidgetInterface>(
        () => const CustomProgressIndicator());
    registerFactoryParamIfNotRegistered<HeaderWidgetInterface, HeaderProps,
        void>((param1, param2) => Header(props: param1));
    registerFactoryParamIfNotRegistered<ProgressBarWidgetInterface,
        ProgressBarProps, void>((param1, param2) => ProgressBar(props: param1));
    registerFactoryParamIfNotRegistered<
        RowButtonGroupWidgetInterface,
        RowButtonGroupProps,
        void>((param1, param2) => RowButtonGroup(props: param1));
    registerFactoryParamIfNotRegistered<
        RowButtonMultiChoicesGroupWidgetInterface,
        RowButtonMultiChoicesGroupProps,
        void>((param1, param2) => RowButtonMultiChoicesGroup(props: param1));
    registerFactoryParamIfNotRegistered<SeparatorWidgetInterface,
        SeparatorProps?, void>((param1, param2) => Separator(props: param1));
    registerFactoryIfNotRegistered<SidebarWidgetInterface>(
        () => const Sidebar());
    registerFactoryIfNotRegistered<StagingBannerWidgetInterface>(
        () => StagingBanner());
    registerFactoryParamIfNotRegistered<StreetViewWidgetInterface,
        StreetViewProps, void>((param1, param2) => StreetView(props: param1));
    registerFactoryParamIfNotRegistered<
        UserButtonDialogWidgetInterface,
        UserButtonDialogProps?,
        void>((param1, param2) => UserButtonDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        NavigationBannerWidgetInterface,
        NavigationBannerProps,
        void>((param1, param2) => NavigationBanner(props: param1));
    registerFactoryParamIfNotRegistered<
        NavigationBannerItemWidgetInterface,
        NavigationBannerItemProps,
        void>((param1, param2) => NavigationBannerItem(props: param1));

    // ---- domains/ui/widgets/animation
    registerFactoryParamIfNotRegistered<ShakeWidgetInterface, ShakeWidgetProps,
        void>((param1, param2) => ShakeWidget(props: param1));

    // ---- domains/ui/widgets/dialog
    registerFactoryParamIfNotRegistered<
        DialogContentWrapperWidgetInterface,
        DialogContentWrapperProps,
        void>((param1, param2) => DialogContentWrapper(props: param1));
    registerFactoryParamIfNotRegistered<
        DialogHeaderWidgetInterface,
        DialogHeaderProps?,
        void>((param1, param2) => DialogHeader(props: param1));
    registerFactoryParamIfNotRegistered<
        DialogWrapperWidgetInterface,
        DialogWrapperProps,
        void>((param1, param2) => DialogWrapper(props: param1));
    registerFactoryParamIfNotRegistered<
        WebViewDialogWidgetInterface,
        WebViewDialogProps,
        void>((param1, param2) => WebViewDialog(props: param1));

    // ---- domains/ui/widgets/forms
    registerFactoryParamIfNotRegistered<
        AddressManualFormWidgetInterface,
        AddressManualFormProps,
        void>((param1, param2) => AddressManualForm(props: param1));
    registerFactoryParamIfNotRegistered<DateInputWidgetInterface,
        DateInputProps, void>((param1, param2) => DateInput(props: param1));
    registerFactoryParamIfNotRegistered<
        MultiSelectDialogWidgetInterface,
        MultiSelectDialogProps,
        void>((param1, param2) => MultiSelectDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        MultiSelectWidgetInterface,
        MultiSelectProps?,
        void>((param1, param2) => MultiSelect(props: param1));
    registerFactoryParamIfNotRegistered<RadioWidgetInterface, RadioProps, void>(
        (param1, param2) => Radio(props: param1));
    registerFactoryParamIfNotRegistered<TextInputWidgetInterface,
        TextInputProps?, void>((param1, param2) => TextInput(props: param1));
    registerFactoryParamIfNotRegistered<
        TextInputWithLabelWidgetInterface,
        TextInputWithLabelProps,
        void>((param1, param2) => TextInputWithLabel(props: param1));
    // picker
    registerFactoryParamIfNotRegistered<PickerWidgetInterface, PickerProps,
        void>((param1, param2) => Picker(props: param1));
    registerFactoryParamIfNotRegistered<
        PickerWidgetInterface<DiscountTypeChoice>,
        PickerProps<DiscountTypeChoice>,
        void>((param1, param2) => Picker<DiscountTypeChoice>(props: param1));
    registerFactoryParamIfNotRegistered<
        PickerWidgetInterface<ServiceOptionItem?>,
        PickerProps<ServiceOptionItem?>,
        void>((param1, param2) => Picker<ServiceOptionItem?>(props: param1));
    registerFactoryParamIfNotRegistered<
        PickerWidgetInterface<TaxLevel>,
        PickerProps<TaxLevel>,
        void>((param1, param2) => Picker<TaxLevel>(props: param1));
    // selects
    registerFactoryParamIfNotRegistered<SelectWidgetInterface, SelectProps,
        void>((param1, param2) => Select(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<bool>,
        SelectProps<bool>,
        void>((param1, param2) => Select<bool>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<String>,
        SelectProps<String>,
        void>((param1, param2) => Select<String>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<OriginDetails>,
        SelectProps<OriginDetails>,
        void>((param1, param2) => Select<OriginDetails>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<CustomerType>,
        SelectProps<CustomerType>,
        void>((param1, param2) => Select<CustomerType>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<ProjectDocumentType>,
        SelectProps<ProjectDocumentType>,
        void>((param1, param2) => Select<ProjectDocumentType>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<PaymentTerms>,
        SelectProps<PaymentTerms>,
        void>((param1, param2) => Select<PaymentTerms>(props: param1));
    registerFactoryParamIfNotRegistered<SelectWidgetInterface<int>,
        SelectProps<int>, void>((param1, param2) => Select<int>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<InsuranceType>,
        SelectProps<InsuranceType>,
        void>((param1, param2) => Select<InsuranceType>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<Deferment>,
        SelectProps<Deferment>,
        void>((param1, param2) => Select<Deferment>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectWidgetInterface<Supplier>,
        SelectProps<Supplier>,
        void>((param1, param2) => Select<Supplier>(props: param1));
    registerFactoryParamIfNotRegistered<
            SelectWidgetInterface<RepresentativeAppraisalType>,
            SelectProps<RepresentativeAppraisalType>,
            void>(
        (param1, param2) => Select<RepresentativeAppraisalType>(props: param1));

    // ------ domains/ui/widgets/forms/address_autocomplete_form_widget
    registerFactoryIfNotRegistered<AddressAutocompleteFormStoreInterface>(
        () => AddressAutocompleteFormStore());

    // ------ domains/ui/widgets/forms/select_dialog_widget
    registerFactoryParamIfNotRegistered<
        SelectDialogStoreInterface,
        SelectDialogStoreParams,
        void>((param1, param2) => SelectDialogStore(params: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogDialogWidgetInterface,
        SelectDialogDialogProps,
        void>((param1, param2) => SelectDialogDialog(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogWidgetInterface,
        SelectDialogProps,
        void>((param1, param2) => SelectDialog(props: param1));
    registerFactoryParamIfNotRegistered<
            SelectDialogStoreInterface<PaymentTerms>,
            SelectDialogStoreParams<PaymentTerms>,
            void>(
        (param1, param2) => SelectDialogStore<PaymentTerms>(params: param1));
    registerFactoryParamIfNotRegistered<
            SelectDialogDialogWidgetInterface<PaymentTerms>,
            SelectDialogDialogProps<PaymentTerms>,
            void>(
        (param1, param2) => SelectDialogDialog<PaymentTerms>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogWidgetInterface<PaymentTerms>,
        SelectDialogProps<PaymentTerms>,
        void>((param1, param2) => SelectDialog<PaymentTerms>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogStoreInterface<int>,
        SelectDialogStoreParams<int>,
        void>((param1, param2) => SelectDialogStore<int>(params: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogDialogWidgetInterface<int>,
        SelectDialogDialogProps<int>,
        void>((param1, param2) => SelectDialogDialog<int>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogWidgetInterface<int>,
        SelectDialogProps<int>,
        void>((param1, param2) => SelectDialog<int>(props: param1));
    registerFactoryParamIfNotRegistered<
            SelectDialogStoreInterface<InsuranceType>,
            SelectDialogStoreParams<InsuranceType>,
            void>(
        (param1, param2) => SelectDialogStore<InsuranceType>(params: param1));
    registerFactoryParamIfNotRegistered<
            SelectDialogDialogWidgetInterface<InsuranceType>,
            SelectDialogDialogProps<InsuranceType>,
            void>(
        (param1, param2) => SelectDialogDialog<InsuranceType>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogWidgetInterface<InsuranceType>,
        SelectDialogProps<InsuranceType>,
        void>((param1, param2) => SelectDialog<InsuranceType>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogStoreInterface<Deferment>,
        SelectDialogStoreParams<Deferment>,
        void>((param1, param2) => SelectDialogStore<Deferment>(params: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogDialogWidgetInterface<Deferment>,
        SelectDialogDialogProps<Deferment>,
        void>((param1, param2) => SelectDialogDialog<Deferment>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogWidgetInterface<Deferment>,
        SelectDialogProps<Deferment>,
        void>((param1, param2) => SelectDialog<Deferment>(props: param1));
    registerFactoryParamIfNotRegistered<
        SelectDialogDialogWidgetInterface<dynamic>,
        SelectDialogDialogProps<dynamic>,
        void>((param1, param2) => SelectDialogDialog<dynamic>(props: param1));

    // ---- domains/ui/widgets/layouts
    registerFactoryParamIfNotRegistered<MainLayoutWidgetInterface,
        MainLayoutProps, void>((param1, param2) => MainLayout(props: param1));

    // ---- domains/ui/widgets/row_button_widget
    registerFactoryIfNotRegistered<RowButtonStoreInterface>(
        () => RowButtonStore());
    registerFactoryParamIfNotRegistered<RowButtonWidgetInterface,
        RowButtonProps, void>((param1, param2) => RowButton(props: param1));
    // ---- domains/ui/widgets/drop_down_menu_widget
    registerFactoryParamIfNotRegistered<
        DropDownMenuWidgetInterface,
        DropDownMenuProps,
        void>((param1, param2) => DropDownMenu(props: param1));

    // navigators:--------------------------------------------------------------
    registerSingletonIfNotRegistered<RootNavigatorInterface>(
        () => RootNavigator());

    // services:----------------------------------------------------------------
    registerSingletonIfNotRegistered<AgencyServiceInterface>(
        () => AgencyService());
    registerSingletonIfNotRegistered<ContactServiceInterface>(
        () => ContactService());
    registerSingletonIfNotRegistered<CustomerServiceInterface>(
        () => CustomerService());
    registerSingletonIfNotRegistered<DiscountCodeServiceInterface>(
        () => DiscountCodesService());
    registerSingletonIfNotRegistered<DocusignLogServiceInterface>(
        () => DocusignLogService());
    registerSingletonIfNotRegistered<EmailServiceInterface>(
        () => EmailService());
    registerSingletonIfNotRegistered<EmailTemplateServiceInterface>(
        () => EmailTemplateService());
    registerSingletonIfNotRegistered<FairServiceInterface>(() => FairService());
    registerSingletonIfNotRegistered<FileDataFamilyServiceInterface>(
        () => FileDataFamilyService());
    registerSingletonIfNotRegistered<FileDataServiceInterface>(
        () => FileDataService());
    registerSingletonIfNotRegistered<NoteServiceInterface>(() => NoteService());
    registerSingletonIfNotRegistered<NotificationTokenServiceInterface>(
        () => NotificationTokenService());
    registerSingletonIfNotRegistered<OrderRowServiceInterface>(
        () => OrderRowService());
    registerSingletonIfNotRegistered<OrderServiceInterface>(
        () => OrderService());
    registerSingletonIfNotRegistered<PriceListItemServiceInterface>(
        () => PriceListItemService());
    registerSingletonIfNotRegistered<PriceListServiceInterface>(
        () => PriceListService());
    registerSingletonIfNotRegistered<RepresentativeServiceInterface>(
        () => RepresentativeService());
    registerSingletonIfNotRegistered<RepresentativeAppraisalServiceInterface>(
        () => RepresentativeAppraisalService());
    registerSingletonIfNotRegistered<ServiceFamilyServiceInterface>(
        () => ServiceFamilyService());
    registerSingletonIfNotRegistered<ServiceOptionItemServiceInterface>(
        () => ServiceOptionItemService());
    registerSingletonIfNotRegistered<ServiceOptionServiceInterface>(
        () => ServiceOptionService());
    registerSingletonIfNotRegistered<ServiceServiceInterface>(
        () => ServiceService());
    registerSingletonIfNotRegistered<ServiceSubFamilyServiceInterface>(
        () => ServiceSubFamilyService());
    registerSingletonIfNotRegistered<SiteSheetServiceInterface>(
        () => SiteSheetService());
    registerSingletonIfNotRegistered<SupplierServiceInterface>(
        () => SupplierService());
    registerSingletonIfNotRegistered<UserSettingServiceInterface>(
        () => UserSettingService());

    // services/externals
    registerSingletonIfNotRegistered<DocusignServiceInterface>(
        () => DocusignService());

    // screens:-----------------------------------------------------------------
    registerFactoryIfNotRegistered<MainScreenInterface>(
        () => const MainScreen());

    registerFactoryIfNotRegistered<BusinessMonitoringScreenInterface>(
        () => const BusinessMonitoringScreen());

    registerFactoryIfNotRegistered<CustomerTabScreenInterface>(
        () => const CustomerTabScreen());

    registerFactoryIfNotRegistered<DiscountCodesScreenInterface>(
        () => DiscountCodesScreen());

    registerFactoryIfNotRegistered<HomeTabScreenInterface>(
        () => const HomeTabScreen());

    registerFactoryIfNotRegistered<LibraryScreenInterface>(
        () => const LibraryScreen());

    registerFactoryIfNotRegistered<SearchScreenInterface>(
        () => const SearchScreen());

    registerFactoryIfNotRegistered<AppraisalsScreenInterface>(
        () => const AppraisalsScreen());

    // screens/auth

    // -- screens/auth/login_screen
    registerFactoryIfNotRegistered<LoginScreenInterface>(
        () => const LoginScreen());
    registerFactoryIfNotRegistered<LoginStoreInterface>(() => LoginStore());

    // -- screens/auth/reset_password_screen
    registerFactoryIfNotRegistered<ResetPasswordStoreInterface>(
        () => ResetPasswordStore());
    registerFactoryParamIfNotRegistered<
        ResetPasswordScreenInterface,
        ResetPasswordScreenArguments,
        void>((param1, param2) => ResetPasswordScreen(arguments: param1));

    // screens/customer
    registerFactoryParamIfNotRegistered<
        CustomerCartScreenInterface,
        CustomerCartScreenArguments,
        void>((param1, param2) => CustomerCartScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<CustomerViewProjectScreenInterface,
        CustomerViewProjectScreenArguments, void>(
      (param1, param2) => CustomerViewProjectScreen(
        arguments: param1,
      ),
    );
    registerFactoryParamIfNotRegistered<
            CustomerViewProjectStreetViewScreenInterface,
            CustomerViewProjectStreetViewScreenArguments,
            void>(
        (param1, param2) =>
            CustomerViewProjectStreetViewScreen(arguments: param1));

    getIt.registerFactoryParam<
        CustomerServicesScreenInterface,
        CustomerServicesScreenArguments,
        void>((param1, param2) => CustomerServicesScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<CustomerServicesSearchScreenInterface,
            CustomerServicesSearchScreenArguments, void>(
        (param1, param2) => CustomerServicesSearchScreen(arguments: param1));

    // -- screens/customer/customer_list_screen
    registerFactoryIfNotRegistered<CustomerListScreenInterface>(
        () => const CustomerListScreen());
    registerFactoryIfNotRegistered<CustomerListStoreInterface>(
        () => CustomerListStore());

    // -- screens/customer/customer_media_screen
    registerFactoryIfNotRegistered<CustomerMediaScreenInterface>(
        () => const CustomerMediaScreen());
    registerFactoryIfNotRegistered<CustomerMediaStoreInterface>(
        () => CustomerMediaStore());

    // -- screens/customer/customer_site_sheet_screen
    registerFactoryParamIfNotRegistered<
        CustomerSiteSheetScreenInterface,
        CustomerSiteSheetScreenArguments,
        void>((param1, param2) => CustomerSiteSheetScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<
        CustomerSiteSheetStoreInterface,
        CustomerSiteSheetStoreParams,
        void>((param1, param2) => CustomerSiteSheetStore(params: param1));

    // -- screens/customer/customer_view_screen
    registerFactoryParamIfNotRegistered<
        CustomerViewScreenInterface,
        CustomerViewScreenArguments,
        void>((param1, param2) => CustomerViewScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<
        CustomerViewStoreInterface,
        CustomerViewStoreParams,
        void>((param1, param2) => CustomerViewStore(params: param1));
    registerFactoryIfNotRegistered<MainAppraisalsScreenInterface>(
        () => MainAppraisalsScreen());
    // -- screens/appraisal/representative_appraisals_screen
    registerFactoryParamIfNotRegistered<RepresentativeAppraisalsScreenInterface,
            RepresentativeAppraisalsScreenArguments, void>(
        (param1, param2) => RepresentativeAppraisalsScreen(arguments: param1));
    // -- screens/appraisal/director_appraisal_agencies_screen
    registerFactoryIfNotRegistered<DirectorAppraisalAgenciesScreenInterface>(
        () => DirectorAppraisalAgenciesScreen());
    // -- screens/appraisal/director_appraisal_agency_screen
    registerFactoryParamIfNotRegistered<DirectorAppraisalAgencyScreenInterface,
            DirectorAppraisalAgencyScreenArguments, void>(
        (param1, param2) => DirectorAppraisalAgencyScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<
        DirectorAppraisalAgencyStoreInterface,
        DirectorAppraisalAgencyStoreParams,
        void>((param1, param2) => DirectorAppraisalAgencyStore(params: param1));
    // -- screens/appraisal/fill_appraisal_screen
    registerFactoryParamIfNotRegistered<
        FillAppraisalScreenInterface,
        FillAppraisalScreenArguments,
        void>((param1, param2) => FillAppraisalScreen(arguments: param1));
    registerFactoryParamIfNotRegistered<
        FillAppraisalStoreInterface,
        FillAppraisalStoreParams,
        void>((param1, param2) => FillAppraisalStore(params: param1));

    // -- screens/home
    registerFactoryIfNotRegistered<HomeScreenInterface>(
        () => const HomeScreen());
    registerFactoryIfNotRegistered<HomeServicesScreenInterface>(
        () => HomeServicesScreen());
    registerFactoryIfNotRegistered<HomeServicesSearchScreenInterface>(
        () => const HomeServicesSearchScreen());

    // stores:------------------------------------------------------------------

    // stores/auth
    registerSingletonIfNotRegistered<AuthStoreInterface>(() => AuthStore());

    // stores/form_error
    registerFactoryParamIfNotRegistered<FormErrorStoreInterface, List<String>,
        void>((param1, param2) => FormErrorStore(param1));

    // stores/location
    registerSingletonIfNotRegistered<LocationStoreInterface>(
      () => LocationStore(),
      isLazy: false,
    );

    // stores/navigation
    registerSingletonIfNotRegistered<NavigationStoreInterface>(
        () => NavigationStore());

    // stores/sync
    registerSingletonIfNotRegistered<SyncStoreInterface>(() => SyncStore());

    // utils:-------------------------------------------------------------------
    registerSingletonIfNotRegistered<AddressAutocompleteUtilsInterface>(
        () => AddressAutocompleteUtils());
    registerSingletonIfNotRegistered<LocationUtilsInterface>(
        () => LocationUtils());
    registerSingletonIfNotRegistered<DateTimeUtilsInterface>(
        () => DateTimeUtils());
    registerSingletonIfNotRegistered<DeviceInfoUtilsInterface>(
        () => DeviceInfoUtils());
    registerSingletonIfNotRegistered<DeviceUtilsInterface>(() => DeviceUtils());
    registerSingletonIfNotRegistered<DialogUtilsInterface>(() => DialogUtils());
    registerSingletonIfNotRegistered<EmailValidatorInterface>(
        () => EmailValidator());
    registerSingletonIfNotRegistered<FileUtilsInterface>(() => FileUtils());
    registerSingletonIfNotRegistered<ImageUtilsInterface>(() => ImageUtils());
    registerSingletonIfNotRegistered<LoaderUtilsInterface>(() => LoaderUtils());
    registerSingletonIfNotRegistered<LocalDbUtilsInterface>(
        () => LocalDbUtils());
    registerSingletonIfNotRegistered<LocalNotificationUtilsInterface>(
        () => LocalNotificationUtils());
    registerSingletonIfNotRegistered<MarkdownUtilsInterface>(
        () => MarkdownUtils());
    registerSingletonIfNotRegistered<NumberFormatterUtilsInterface>(
        () => NumberFormatterUtils());
    registerSingletonIfNotRegistered<PhoneValidatorInterface>(
        () => PhoneValidator());
    registerSingletonIfNotRegistered<PriceCalculatorUtilsInterface>(
        () => PriceCalculatorUtils());
    registerSingletonIfNotRegistered<StringUtilsInterface>(() => StringUtils());
    registerSingletonIfNotRegistered<PhoneUtilsInterface>(() => PhoneUtils());
    registerSingletonIfNotRegistered<UuidUtilsInterface>(() => UuidUtils());
    registerSingletonIfNotRegistered<StreamTransformerUtilsInterface>(
        () => StreamTransformerUtils());
    registerSingletonIfNotRegistered<StreamUtilsInterface>(() => StreamUtils());
  }

  static registerSingletonIfNotRegistered<T extends Object>(
      T Function() instance,
      {bool isLazy = true}) {
    if (!getIt.isRegistered<T>()) {
      if (isLazy) {
        getIt.registerLazySingleton<T>(instance);
      } else {
        getIt.registerSingleton<T>(instance());
      }
    }
  }

  static registerFactoryParamIfNotRegistered<T extends Object, P1, P2>(
      T Function(P1, P2) instance) {
    if (!getIt.isRegistered<T>()) {
      getIt.registerFactoryParam<T, P1, P2>(instance);
    }
  }

  static registerFactoryIfNotRegistered<T extends Object>(
      T Function() instance) {
    if (!getIt.isRegistered<T>()) {
      getIt.registerFactory<T>(instance);
    }
  }
}
