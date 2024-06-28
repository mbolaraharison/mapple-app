library maple_common;

export 'src/app.dart';
export 'src/maple_common.dart';
export 'src/di/service_locator.dart';

// constants:-------------------------------------------------------------------

export 'src/constants/app_info_interface.dart';
export 'src/constants/app_theme_data_interface.dart';
export 'src/constants/image_painter_text_delegate.dart';
export 'src/constants/maple_common_assets.dart';
export 'src/constants/maple_common_colors.dart';
export 'src/constants/tab.dart';

// data:------------------------------------------------------------------------

// data/constants
export 'src/data/constants/cart_status.dart';
export 'src/data/constants/cash_payment_method.dart';
export 'src/data/constants/civility.dart';
export 'src/data/constants/customer_type.dart';
export 'src/data/constants/deferment.dart';
export 'src/data/constants/discount_code_type.dart';
export 'src/data/constants/docusign_log_action.dart';
export 'src/data/constants/file_data_mode.dart';
export 'src/data/constants/file_data_type.dart';
export 'src/data/constants/fill_appraisal_screen_tab.dart';
export 'src/data/constants/financing_payment_method.dart';
export 'src/data/constants/funding_status.dart';
export 'src/data/constants/insurance_type.dart';
export 'src/data/constants/order_status.dart';
export 'src/data/constants/order_type.dart';
export 'src/data/constants/origin_details.dart';
export 'src/data/constants/origin.dart';
export 'src/data/constants/payment_terms.dart';
export 'src/data/constants/price_list_type.dart';
export 'src/data/constants/price_list_unit.dart';
export 'src/data/constants/project_document_type.dart';
export 'src/data/constants/project_status.dart';
export 'src/data/constants/representative_appraisal_type.dart';
export 'src/data/constants/representative_appraisal_question_response.dart';
export 'src/data/constants/role.dart';
export 'src/data/constants/service_category.dart';
export 'src/data/constants/signing_method.dart';
export 'src/data/constants/site_sheet.dart';
export 'src/data/constants/sync_status.dart';
export 'src/data/constants/tax_level.dart';
export 'src/data/constants/tax_system.dart';

// data/dao

// -- data/dao/drift_dao
export 'src/data/dao/drift_dao/abstract_drift_dao.dart';
export 'src/data/dao/drift_dao/agency_drift_dao.dart';
export 'src/data/dao/drift_dao/contact_drift_dao.dart';
export 'src/data/dao/drift_dao/customer_drift_dao.dart';
export 'src/data/dao/drift_dao/discount_code_drift_dao.dart';
export 'src/data/dao/drift_dao/discount_code_service_drift_dao.dart';
export 'src/data/dao/drift_dao/discount_code_service_family_drift_dao.dart';
export 'src/data/dao/drift_dao/discount_code_service_sub_family_drift_dao.dart';
export 'src/data/dao/drift_dao/email_template_drift_dao.dart';
export 'src/data/dao/drift_dao/fair_drift_dao.dart';
export 'src/data/dao/drift_dao/file_data_drift_dao.dart';
export 'src/data/dao/drift_dao/file_data_family_drift_dao.dart';
export 'src/data/dao/drift_dao/note_drift_dao.dart';
export 'src/data/dao/drift_dao/order_contact_drift_dao.dart';
export 'src/data/dao/drift_dao/order_drift_dao.dart';
export 'src/data/dao/drift_dao/order_row_drift_dao.dart';
export 'src/data/dao/drift_dao/price_list_drift_dao.dart';
export 'src/data/dao/drift_dao/price_list_item_drift_dao.dart';
export 'src/data/dao/drift_dao/representative_drift_dao.dart';
export 'src/data/dao/drift_dao/service_drift_dao.dart';
export 'src/data/dao/drift_dao/service_family_drift_dao.dart';
export 'src/data/dao/drift_dao/service_option_drift_dao.dart';
export 'src/data/dao/drift_dao/service_option_item_drift_dao.dart';
export 'src/data/dao/drift_dao/service_sub_family_drift_dao.dart';
export 'src/data/dao/drift_dao/supplier_drift_dao.dart';
export 'src/data/dao/drift_dao/user_setting_drift_dao.dart';

// -- data/dao/firestore_dao
export 'src/data/dao/firestore_dao/abstract_firestore_dao.dart';
export 'src/data/dao/firestore_dao/firestore_dao_interface.dart';
export 'src/data/dao/firestore_dao/agency_firestore_dao.dart';
export 'src/data/dao/firestore_dao/contact_firestore_dao.dart';
export 'src/data/dao/firestore_dao/customer_firestore_dao.dart';
export 'src/data/dao/firestore_dao/discount_code_firestore_dao.dart';
export 'src/data/dao/firestore_dao/docusign_log_firestore_dao.dart';
export 'src/data/dao/firestore_dao/email_firestore_dao.dart';
export 'src/data/dao/firestore_dao/email_template_firestore_dao.dart';
export 'src/data/dao/firestore_dao/fair_firestore_dao.dart';
export 'src/data/dao/firestore_dao/file_data_family_firestore_dao.dart';
export 'src/data/dao/firestore_dao/file_data_firestore_dao.dart';
export 'src/data/dao/firestore_dao/integrity_job_firestore_dao.dart';
export 'src/data/dao/firestore_dao/note_firestore_dao.dart';
export 'src/data/dao/firestore_dao/notification_token_firestore_dao.dart';
export 'src/data/dao/firestore_dao/order_firestore_dao.dart';
export 'src/data/dao/firestore_dao/order_row_firestore_dao.dart';
export 'src/data/dao/firestore_dao/price_list_firestore_dao.dart';
export 'src/data/dao/firestore_dao/price_list_item_firestore_dao.dart';
export 'src/data/dao/firestore_dao/representative_firestore_dao.dart';
export 'src/data/dao/firestore_dao/representative_appraisal_firestore_dao.dart';
export 'src/data/dao/firestore_dao/service_family_firestore_dao.dart';
export 'src/data/dao/firestore_dao/service_firestore_dao.dart';
export 'src/data/dao/firestore_dao/service_option_firestore_dao.dart';
export 'src/data/dao/firestore_dao/service_option_item_firestore_dao.dart';
export 'src/data/dao/firestore_dao/service_sub_family_firestore_dao.dart';
export 'src/data/dao/firestore_dao/site_sheet_firestore_dao.dart';
export 'src/data/dao/firestore_dao/supplier_firestore_dao.dart';
export 'src/data/dao/firestore_dao/user_setting_firestore_dao.dart';

// data/databases

export 'src/data/databases/app_database.dart';
export 'src/data/databases/agency_database.dart';

// -- data/databases/tables
export 'src/data/databases/tables/default_table_mixin.dart';
export 'src/data/databases/tables/agencies_table.dart';
export 'src/data/databases/tables/contacts_table.dart';
export 'src/data/databases/tables/customers_table.dart';
export 'src/data/databases/tables/discount_codes_service_families_table.dart';
export 'src/data/databases/tables/discount_codes_service_sub_families_table.dart';
export 'src/data/databases/tables/discount_codes_services_table.dart';
export 'src/data/databases/tables/discount_codes_table.dart';
export 'src/data/databases/tables/email_templates_table.dart';
export 'src/data/databases/tables/fairs_table.dart';
export 'src/data/databases/tables/file_data_families_table.dart';
export 'src/data/databases/tables/file_datas_table.dart';
export 'src/data/databases/tables/notes_table.dart';
export 'src/data/databases/tables/order_rows_table.dart';
export 'src/data/databases/tables/orders_contacts_table.dart';
export 'src/data/databases/tables/orders_table.dart';
export 'src/data/databases/tables/price_list_items_table.dart';
export 'src/data/databases/tables/price_lists_table.dart';
export 'src/data/databases/tables/representatives_table.dart';
export 'src/data/databases/tables/service_families_table.dart';
export 'src/data/databases/tables/service_option_items_table.dart';
export 'src/data/databases/tables/service_options_table.dart';
export 'src/data/databases/tables/service_sub_families_table.dart';
export 'src/data/databases/tables/services_table.dart';
export 'src/data/databases/tables/suppliers_table.dart';
export 'src/data/databases/tables/user_settings_table.dart';

// -- data/databases/type_converters
export 'src/data/databases/type_converters/geo_point_converter.dart';
export 'src/data/databases/type_converters/list_string_converter.dart';

// data/dto
export 'src/data/dto/address_dto.dart';
export 'src/data/dto/order_form_contact_dto.dart';
export 'src/data/dto/order_form_discount_row_dto.dart';
export 'src/data/dto/order_form_dto.dart';
export 'src/data/dto/order_form_order_rows_dto.dart';
export 'src/data/dto/order_form_representative_dto.dart';
export 'src/data/dto/order_form_tax_column_dto.dart';
export 'src/data/dto/representative_appraisal_form_dto.dart';

// data/models
export 'src/data/models/abstract_base_model.dart';
export 'src/data/models/abstract_is_soft_deletable.dart';
export 'src/data/models/agency_model.dart';
export 'src/data/models/contact_model.dart';
export 'src/data/models/customer_model.dart';
export 'src/data/models/discount_code_model.dart';
export 'src/data/models//discount_code_service_family_model.dart';
export 'src/data/models/discount_code_service_model.dart';
export 'src/data/models/discount_code_service_sub_family_model.dart';
export 'src/data/models/docusign_log_model.dart';
export 'src/data/models/email_model.dart';
export 'src/data/models/email_template_model.dart';
export 'src/data/models/fair_model.dart';
export 'src/data/models/file_data_family_model.dart';
export 'src/data/models/file_data_model.dart';
export 'src/data/models/integrity_job_model.dart';
export 'src/data/models/note_model.dart';
export 'src/data/models/notification_token_model.dart';
export 'src/data/models/order_contact_model.dart';
export 'src/data/models/order_model.dart';
export 'src/data/models/order_row_model.dart';
export 'src/data/models/parameter_model.dart';
export 'src/data/models/price_list_item_model.dart';
export 'src/data/models/price_list_model.dart';
export 'src/data/models/representative_model.dart';
export 'src/data/models/representative_appraisal_model.dart';
export 'src/data/models/select_for_signature_model.dart';
export 'src/data/models/service_family_model.dart';
export 'src/data/models/service_model.dart';
export 'src/data/models/service_option_item_model.dart';
export 'src/data/models/service_option_model.dart';
export 'src/data/models/service_sub_family_model.dart';
export 'src/data/models/supplier_model.dart';
export 'src/data/models/signer.dart';
export 'src/data/models/site_sheet_model.dart';
export 'src/data/models/user_setting_model.dart';

// -- data/models/docusign
export 'src/data/models/docusign/carbon_copy_model.dart';
export 'src/data/models/docusign/document_model.dart';
export 'src/data/models/docusign/envelope_definition_model.dart';
export 'src/data/models/docusign/recipient_sms_authentication_model.dart';
export 'src/data/models/docusign/recipient_view_request_model.dart';
export 'src/data/models/docusign/recipients_model.dart';
export 'src/data/models/docusign/sign_here_tab_model.dart';
export 'src/data/models/docusign/signer_model.dart';
export 'src/data/models/docusign/tabs_model.dart';

// domains:---------------------------------------------------------------------

// domains/account

// -- domains/account/navigators
export 'src/domains/account/navigators/account_dialog_navigator.dart';
export 'src/domains/account/navigators/sync_navigator.dart';

// -- domains/account/stores
export 'src/domains/account/stores/account_dialog_store.dart';

// -- domains/account/widgets
export 'src/domains/account/widgets/account_about_widget.dart';
export 'src/domains/account/widgets/account_dialog_widget.dart';
export 'src/domains/account/widgets/account_home_widget.dart';
export 'src/domains/account/widgets/account_infos_widget.dart';
export 'src/domains/account/widgets/account_select_fair_widget.dart';
export 'src/domains/account/widgets/sync_error_widget.dart';

// ---- domains/account/widgets/account_reset_password_widget
export 'src/domains/account/widgets/account_reset_password_widget/account_reset_password_store.dart';
export 'src/domains/account/widgets/account_reset_password_widget/account_reset_password_widget.dart';

// ---- domains/account/widgets/account_select_agency_widget
export 'src/domains/account/widgets/select_agency_widget/select_agency_store.dart';
export 'src/domains/account/widgets/select_agency_widget/select_agency_widget.dart';

// domains/appraisal

// -- domains/appraisal/navigators
export 'src/domains/appraisal/navigators/appraisals_navigator.dart';
export 'src/domains/appraisal/navigators/add_representative_appraisal_navigator.dart';

// ---- domains/appraisal/navigators/arguments
export 'src/domains/appraisal/navigators/arguments/representative_appraisals_screen_arguments.dart';
export 'src/domains/appraisal/navigators/arguments/fill_appraisal_screen_arguments.dart';
export 'src/domains/appraisal/navigators/arguments/director_appraisal_agency_screen_arguments.dart';

// -- domains/appraisal/utils
export 'src/domains/appraisal/utils/representative_appraisal_form_generator.dart';

// -- domains/appraisal/widgets
export 'src/domains/appraisal/widgets/director_appraisals_history_view_widget.dart';
export 'src/domains/appraisal/widgets/director_appraisals_list_view_widget.dart';
export 'src/domains/appraisal/widgets/representatives_list_view_widget.dart';

// -- domains/appraisal/widgets/add_representative_appraisal_dialog_widget
export 'src/domains/appraisal/widgets/add_representative_appraisal_dialog_widget/add_representative_appraisal_dialog_store.dart';
export 'src/domains/appraisal/widgets/add_representative_appraisal_dialog_widget/add_representative_appraisal_dialog_widget.dart';
export 'src/domains/appraisal/widgets/add_representative_appraisal_dialog_widget/add_representative_appraisal_home_widget.dart';
export 'src/domains/appraisal/widgets/add_representative_appraisal_dialog_widget/add_representative_appraisal_select_type_widget.dart';

// -- domains/appraisal/widgets/badge_dialog_widget
export 'src/domains/appraisal/widgets/badge_dialog_widget/badge_dialog_widget.dart';

// -- domains/appraisal/widgets/configure_representative_appraisal_widget
export 'src/domains/appraisal/widgets/configure_representative_appraisal_widget/configure_representative_appraisal_dialog_store.dart';
export 'src/domains/appraisal/widgets/configure_representative_appraisal_widget/configure_representative_appraisal_dialog_widget.dart';

// -- domains/appraisal/widgets/representative_appraisal_recall_dialog_widget
export 'src/domains/appraisal/widgets/representative_appraisal_recall_dialog_widget/representative_appraisal_recall_dialog_store.dart';
export 'src/domains/appraisal/widgets/representative_appraisal_recall_dialog_widget/representative_appraisal_recall_dialog_widget.dart';

// domains/auth

// -- domains/auth/widgets

// -- domains/auth/widgets/reset_password_dialog
export 'src/domains/auth/widgets/reset_password_dialog/reset_password_dialog_store.dart';
export 'src/domains/auth/widgets/reset_password_dialog/reset_password_dialog_widget.dart';

// domains/cart

// -- domains/cart/constants
export 'src/domains/cart/constants/discount_type_choice.dart';

// -- domains/cart/navigators
export 'src/domains/cart/navigators/cart_navigator.dart';
export 'src/domains/cart/navigators/cart_terms_navigator.dart';
export 'src/domains/cart/navigators/cart_add_select_signatory_dialog_navigator.dart';

// ---- domains/cart/navigators/arguments
export 'src/domains/cart/navigators/arguments/terms_select_signature_method_arguments.dart';
export 'src/domains/cart/navigators/arguments/cart_create_or_edit_contact_arguments.dart';

// -- domains/cart/stores
export 'src/domains/cart/stores/customer_order_store.dart';
export 'src/domains/cart/stores/finalization_step_store.dart';
export 'src/domains/cart/stores/order_step_store.dart';
export 'src/domains/cart/stores/payment_step_store.dart';
export 'src/domains/cart/stores/signature_step_store.dart';

// -- domains/cart/types
export 'src/domains/cart/types/signature_avatar.dart';

// -- domains/cart/utils
export 'src/domains/cart/utils/order_form_generator.dart';

// -- domains/cart/widgets
export 'src/domains/cart/widgets/cart_finalization_add_contact_dialog_widget.dart';
export 'src/domains/cart/widgets/cart_finalization_add_rep_dialog_widget.dart';
export 'src/domains/cart/widgets/cart_signature_select_contact_for_signing_dialog_widget.dart';
export 'src/domains/cart/widgets/cart_signature_select_rep_for_signing_dialog_widget.dart';
export 'src/domains/cart/widgets/cart_finalization_widget.dart';
export 'src/domains/cart/widgets/cart_order_widget.dart';
export 'src/domains/cart/widgets/cart_payment_widget.dart';
export 'src/domains/cart/widgets/cart_signature_widget.dart';
export 'src/domains/cart/widgets/send_quote_dialog_widget.dart';
export 'src/domains/cart/widgets/reload_order_row_prices_dialog_widget.dart';

// ---- domains/cart/widgets/cart_add_select_signatory_dialog
export 'src/domains/cart/widgets/cart_add_select_signatory_dialog/cart_add_select_signatory_dialog_widget.dart';
export 'src/domains/cart/widgets/cart_add_select_signatory_dialog/cart_create_or_edit_contact_widget.dart';
export 'src/domains/cart/widgets/cart_add_select_signatory_dialog/cart_select_signatory_widget.dart';

// ---- domains/cart/widgets/discount_dialog_widget
export 'src/domains/cart/widgets/discount_dialog_widget/discount_dialog_store.dart';
export 'src/domains/cart/widgets/discount_dialog_widget/discount_dialog_widget.dart';

// ---- domains/cart/widgets/suppliers_dialog_widget
export 'src/domains/cart/widgets/suppliers_dialog_widget/suppliers_dialog_store.dart';
export 'src/domains/cart/widgets/suppliers_dialog_widget/suppliers_dialog_widget.dart';

// ---- domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget
export 'src/domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget/service_with_supplier_store.dart';
export 'src/domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget/service_with_supplier_widget.dart';

// ---- domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget/select_supplier_widget
export 'src/domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget/select_supplier_widget/select_supplier_dialog_store.dart';
export 'src/domains/cart/widgets/suppliers_dialog_widget/service_with_supplier_widget/select_supplier_widget/select_supplier_dialog_widget.dart';

// ---- domains/cart/widgets/terms_dialog_widget
export 'src/domains/cart/widgets/terms_dialog_widget/terms_dialog_store.dart';
export 'src/domains/cart/widgets/terms_dialog_widget/terms_dialog_widget.dart';

// ---- domains/cart/widgets/terms_document_dialog_widget
export 'src/domains/cart/widgets/terms_document_dialog_widget/terms_document_dialog_store.dart';
export 'src/domains/cart/widgets/terms_document_dialog_widget/terms_document_dialog_widget.dart';
export 'src/domains/cart/widgets/terms_document_dialog_widget/terms_document_pad_sign_widget.dart';
export 'src/domains/cart/widgets/terms_document_dialog_widget/terms_select_signature_method_widget.dart';

// ---- domains/cart/widgets/vat_certificate_dialog_widget
export 'src/domains/cart/widgets/vat_certificate_dialog_widget/vat_certificate_dialog_store.dart';
export 'src/domains/cart/widgets/vat_certificate_dialog_widget/vat_certificate_dialog_widget.dart';

// domains/customer

// -- domains/customer/navigators
export 'src/domains/customer/navigators/customer_tab_navigator.dart';
export 'src/domains/customer/navigators/edit_customer_dialog_navigator.dart';

// ---- domains/customer/navigators/arguments
export 'src/domains/customer/navigators/arguments/customer_cart_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_services_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_site_sheet_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_services_search_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_view_project_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_view_project_street_view_screen_arguments.dart';
export 'src/domains/customer/navigators/arguments/customer_view_screen_arguments.dart';

// -- domains/customer/types
export 'src/domains/customer/types/customer_list_view_types.dart';
export 'src/domains/customer/types/place.dart';

// -- domains/customer/utils
export 'src/domains/customer/utils/site_sheet_generator.dart';

// -- domains/customer/widgets
export 'src/domains/customer/widgets/add_edit_contact_dialog_widget.dart';
export 'src/domains/customer/widgets/customers_project_card_widget.dart';
export 'src/domains/customer/widgets/select_customer_signatories_widget.dart';

// -- domains/customer/widgets/contact_form_widget
export 'src/domains/customer/widgets/contact_form_widget/contact_form_store.dart';
export 'src/domains/customer/widgets/contact_form_widget/contact_form_widget.dart';

// -- domains/customer/widgets/customer_file_card_widget
export 'src/domains/customer/widgets/customer_file_card_widget/customer_file_card_widget.dart';

// ---- domains/customer/widgets/customers_list_view_widget
export 'src/domains/customer/widgets/customers_list_view_widget/customers_list_view_store.dart';
export 'src/domains/customer/widgets/customers_list_view_widget/customers_list_view_widget.dart';

// ---- domains/customer/widgets/customers_map_view_widget
export 'src/domains/customer/widgets/customers_map_view_widget/customers_map_view_store.dart';
export 'src/domains/customer/widgets/customers_map_view_widget/customers_map_view_widget.dart';

// ---- domains/customer/widgets/edit_customer_dialog_widget
export 'src/domains/customer/widgets/edit_customer_dialog_widget/edit_customer_dialog_store.dart';
export 'src/domains/customer/widgets/edit_customer_dialog_widget/edit_customer_dialog_widget.dart';
export 'src/domains/customer/widgets/edit_customer_dialog_widget/edit_customer_infos_widget.dart';
export 'src/domains/customer/widgets/edit_customer_dialog_widget/edit_customer_select_origin_widget.dart';
export 'src/domains/customer/widgets/edit_customer_dialog_widget/edit_customer_select_type_widget.dart';

// ---- domains/customer/widgets/manage_note_dialog_widget
export 'src/domains/customer/widgets/manage_note_dialog_widget/manage_note_dialog_store.dart';
export 'src/domains/customer/widgets/manage_note_dialog_widget/manage_note_dialog_widget.dart';

// ---- domains/customer/widgets/site_sheet
export 'src/domains/customer/widgets/site_sheet/comments_tab.dart';
export 'src/domains/customer/widgets/site_sheet/connection_tab.dart';
export 'src/domains/customer/widgets/site_sheet/cover_tab.dart';
export 'src/domains/customer/widgets/site_sheet/drawing_area_dialog.dart';
export 'src/domains/customer/widgets/site_sheet/exposure_tab.dart';
export 'src/domains/customer/widgets/site_sheet/facade_tab.dart';
export 'src/domains/customer/widgets/site_sheet/fascia_board_tab.dart';
export 'src/domains/customer/widgets/site_sheet/gutter_tab.dart';
export 'src/domains/customer/widgets/site_sheet/insulation_tab.dart';
export 'src/domains/customer/widgets/site_sheet/roof_tab.dart';
export 'src/domains/customer/widgets/site_sheet/statement_of_information_tab.dart';
export 'src/domains/customer/widgets/site_sheet/wood_treatment_tab.dart';

// domains/discount_code

// -- domains/discount_code/widgets

// ---- domains/discount_code/widgets/save_discount_code_dialog_widget
export 'src/domains/discount_code/widgets/save_discount_code_dialog_widget/save_discount_code_dialog_store.dart';
export 'src/domains/discount_code/widgets/save_discount_code_dialog_widget/save_discount_code_dialog_widget.dart';

// domains/home

// -- domains/home/navigators
export 'src/domains/home/navigators/home_tab_navigator.dart';

// domains/media

// -- domains/media/widgets

// ---- domains/media/widgets/media_card_widget
export 'src/domains/media/widgets/media_card_widget/media_card_widget.dart';

// domains/pdf

// -- domains/pdf/types
export 'src/domains/pdf/types/pdf_select_value.dart';

// -- domains/pdf/widgets
export 'src/domains/pdf/widgets/pdf_banner_widget.dart';
export 'src/domains/pdf/widgets/pdf_checkbox_widget.dart';
export 'src/domains/pdf/widgets/pdf_date_field_widget.dart';
export 'src/domains/pdf/widgets/pdf_dotted_line_widget.dart';
export 'src/domains/pdf/widgets/pdf_select_widget.dart';
export 'src/domains/pdf/widgets/pdf_text_field_widget.dart';

// domains/project

// -- domains/project/navigators
export 'src/domains/project/navigators/add_edit_project_navigator.dart';
export 'src/domains/project/navigators/create_project_navigator.dart';

// ---- domains/project/navigators/arguments
export 'src/domains/project/navigators/arguments/select_address_arguments.dart';

// -- domains/project/stores
export 'src/domains/project/stores/abstract_address_store.dart';
export 'src/domains/project/stores/add_edit_project_dialog_store.dart';
export 'src/domains/project/stores/create_project_dialog_store.dart';

// -- domains/project/widgets
export 'src/domains/project/widgets/address_widget.dart';
export 'src/domains/project/widgets/select_document_to_open_widget.dart';

// ---- domains/project/widgets/add_edit_project_dialog
export 'src/domains/project/widgets/add_edit_project_dialog/add_edit_project_dialog_widget.dart';
export 'src/domains/project/widgets/add_edit_project_dialog/add_edit_project_infos_widget.dart';
export 'src/domains/project/widgets/add_edit_project_dialog/add_edit_project_order_meeting_origin_widget.dart';

// ---- domains/project/widgets/create_project_dialog_widget
export 'src/domains/project/widgets/create_project_dialog_widget/add_edit_contact_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/contacts_list_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/create_customer_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/create_project_dialog_title_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/create_project_dialog_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/confirm_duplicate_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/how_find_us_widget.dart';
export 'src/domains/project/widgets/create_project_dialog_widget/select_type_widget.dart';

// domains/services

// -- domains/services/widgets
export 'src/domains/services/widgets/services_floating_buttons_widget.dart';

// -- domains/services/widgets/services_browser_widget
export 'src/domains/services/widgets/services_browser_widget/services_browser_store.dart';
export 'src/domains/services/widgets/services_browser_widget/services_browser_widget.dart';

// -- domains/services/widgets/services_search_widget
export 'src/domains/services/widgets/services_search_widget/services_search_store.dart';
export 'src/domains/services/widgets/services_search_widget/services_search_widget.dart';

// -- domains/services/widgets/service_dialog_widget
export 'src/domains/services/widgets/service_dialog_widget/service_dialog_store.dart';
export 'src/domains/services/widgets/service_dialog_widget/service_dialog_widget.dart';

// domains/ui

// -- domains/ui/constants
export 'src/domains/ui/constants/header_mode.dart';

// -- domains/ui/types
export 'src/domains/ui/types/file_data_preview.dart';
export 'src/domains/ui/types/picker_choice.dart';
export 'src/domains/ui/types/row_button_item.dart';
export 'src/domains/ui/types/select_choice.dart';
export 'src/domains/ui/types/yes_no_choices.dart';

// -- domains/ui/widgets
export 'src/domains/ui/widgets/avatar_widget.dart';
export 'src/domains/ui/widgets/card_widget.dart';
export 'src/domains/ui/widgets/custom_progress_indicator_widget.dart';
export 'src/domains/ui/widgets/header_widget.dart';
export 'src/domains/ui/widgets/progress_bar_widget.dart';
export 'src/domains/ui/widgets/row_button_group_widget.dart';
export 'src/domains/ui/widgets/row_button_multi_choices_group_widget.dart';
export 'src/domains/ui/widgets/separator_widget.dart';
export 'src/domains/ui/widgets/sidebar_widget.dart';
export 'src/domains/ui/widgets/staging_banner_widget.dart';
export 'src/domains/ui/widgets/street_view_widget.dart';
export 'src/domains/ui/widgets/user_button_dialog_widget.dart';
export 'src/domains/ui/widgets/navigation_banner_widget.dart';
export 'src/domains/ui/widgets/navigation_banner_item_widget.dart';

// ---- domains/ui/widgets/animation
export 'src/domains/ui/widgets/animation/shake_widget.dart';

// ---- domains/ui/widgets/dialog
export 'src/domains/ui/widgets/dialog/dialog_content_wrapper_widget.dart';
export 'src/domains/ui/widgets/dialog/dialog_header_widget.dart';
export 'src/domains/ui/widgets/dialog/dialog_wrapper_widget.dart';
export 'src/domains/ui/widgets/dialog/web_view_dialog_widget.dart';

// ---- domains/ui/widgets/forms
export 'src/domains/ui/widgets/forms/address_manual_form_widget.dart';
export 'src/domains/ui/widgets/forms/date_input_widget.dart';
export 'src/domains/ui/widgets/forms/multi_select_dialog_widget.dart';
export 'src/domains/ui/widgets/forms/multi_select_widget.dart';
export 'src/domains/ui/widgets/forms/picker_widget.dart';
export 'src/domains/ui/widgets/forms/radio_widget.dart';
export 'src/domains/ui/widgets/forms/select_widget.dart';
export 'src/domains/ui/widgets/forms/text_input_widget.dart';
export 'src/domains/ui/widgets/forms/text_input_with_label_widget.dart';

// ------ domains/ui/widgets/forms/address_autocomplete_form_widget
export 'src/domains/ui/widgets/forms/address_autocomplete_form_widget/address_autocomplete_form_store.dart';
export 'src/domains/ui/widgets/forms/address_autocomplete_form_widget/address_autocomplete_form_widget.dart';

// ------ domains/ui/widgets/forms/select_dialog_widget
export 'src/domains/ui/widgets/forms/select_dialog_widget/select_dialog_dialog_widget.dart';
export 'src/domains/ui/widgets/forms/select_dialog_widget/select_dialog_store.dart';
export 'src/domains/ui/widgets/forms/select_dialog_widget/select_dialog_widget.dart';

// ---- domains/ui/widgets/layouts
export 'src/domains/ui/widgets/layouts/main_layout_widget.dart';

// ---- domains/ui/widgets/row_button_widget
export 'src/domains/ui/widgets/row_button_widget/row_button_store.dart';
export 'src/domains/ui/widgets/row_button_widget/row_button_widget.dart';

// ---- domains/ui/widgets/drop_down_menu_widget
export 'src/domains/ui/widgets/drop_down_menu_widget/drop_down_menu_widget.dart';

// exceptions:------------------------------------------------------------------
export 'src/exceptions/foreign_key_exception.dart';
export 'src/exceptions/reset_password_exception.dart';
export 'src/exceptions/validation_exception.dart';

// extensions:------------------------------------------------------------------
export 'src/extensions/string_extension.dart';

// mixins:----------------------------------------------------------------------
export 'src/mixins/private_directory_mixin.dart';

// navigators:------------------------------------------------------------------
export 'src/navigators/root_navigator.dart';

// navigators/arguments
export 'src/navigators/arguments/reset_password_screen_arguments.dart';

// screens:---------------------------------------------------------------------

export 'src/screens/business_monitoring_screen.dart';
export 'src/screens/customer_tab_screen.dart';
export 'src/screens/discount_codes_screen.dart';
export 'src/screens/home_tab_screen.dart';
export 'src/screens/library_screen.dart';
export 'src/screens/main_screen.dart';
export 'src/screens/search_screen.dart';
export 'src/screens/appraisals_screen.dart';

// screens/appraisal
export 'src/screens/appraisal/main_appraisals_screen.dart';
export 'src/screens/appraisal/representative_appraisals_screen.dart';
export 'src/screens/appraisal/director_appraisal_agencies_screen.dart';

// screens/appraisal/fill_appraisal_screen
export 'src/screens/appraisal/fill_appraisal_screen/fill_appraisal_screen.dart';
export 'src/screens/appraisal/fill_appraisal_screen/fill_appraisal_store.dart';

// screens/appraisal/director_appraisal_agency_screen
export 'src/screens/appraisal/director_appraisal_agency_screen/director_appraisal_agency_screen.dart';
export 'src/screens/appraisal/director_appraisal_agency_screen/director_appraisal_agency_store.dart';

// screens/auth

// -- screens/auth/login_screen
export 'src/screens/auth/login_screen/login_screen.dart';
export 'src/screens/auth/login_screen/login_store.dart';

// -- screens/auth/reset_password_screen
export 'src/screens/auth/reset_password_screen/reset_password_screen.dart';
export 'src/screens/auth/reset_password_screen/reset_password_store.dart';

// screens/customer
export 'src/screens/customer/customer_cart_screen.dart';
export 'src/screens/customer/customer_view_project_screen.dart';
export 'src/screens/customer/customer_view_project_street_view_screen.dart';
export 'src/screens/customer/customer_services_screen.dart';
export 'src/screens/customer/customer_services_search_screen.dart';

// -- screens/customer/customer_list_screen
export 'src/screens/customer/customer_list_screen/customer_list_screen.dart';
export 'src/screens/customer/customer_list_screen/customer_list_store.dart';

// -- screens/customer/customer_media_screen
export 'src/screens/customer/customer_media_screen/customer_media_screen.dart';
export 'src/screens/customer/customer_media_screen/customer_media_store.dart';

// -- screens/customer/customer_site_sheet_screen
export 'src/screens/customer/customer_site_sheet_screen/customer_site_sheet_screen.dart';
export 'src/screens/customer/customer_site_sheet_screen/customer_site_sheet_store.dart';

// -- screens/customer/customer_view_screen
export 'src/screens/customer/customer_view_screen/customer_view_screen.dart';
export 'src/screens/customer/customer_view_screen/customer_view_store.dart';

// -- screens/home
export 'src/screens/home/home_screen.dart';
export 'src/screens/home/home_services_screen.dart';
export 'src/screens/home/home_services_search_screen.dart';

// services:--------------------------------------------------------------------

export 'src/services/abstract_model_service.dart';
export 'src/services/agency_service.dart';
export 'src/services/contact_service.dart';
export 'src/services/customer_service.dart';
export 'src/services/discount_codes_service.dart';
export 'src/services/docusign_log_service.dart';
export 'src/services/email_service.dart';
export 'src/services/email_template_service.dart';
export 'src/services/fair_service.dart';
export 'src/services/file_data_family_service.dart';
export 'src/services/file_data_service.dart';
export 'src/services/note_service.dart';
export 'src/services/notification_token_service.dart';
export 'src/services/order_row_service.dart';
export 'src/services/order_service.dart';
export 'src/services/price_list_item_service.dart';
export 'src/services/price_list_service.dart';
export 'src/services/representative_appraisal_service.dart';
export 'src/services/representative_service.dart';
export 'src/services/service_family_service.dart';
export 'src/services/service_option_item_service.dart';
export 'src/services/service_option_service.dart';
export 'src/services/service_service.dart';
export 'src/services/service_sub_family_service.dart';
export 'src/services/site_sheet_service.dart';
export 'src/services/supplier_service.dart';
export 'src/services/user_setting_service.dart';

// -- services/externals
export 'src/services/externals/docusign_service.dart';

// stores:----------------------------------------------------------------------

// stores/auth
export 'src/stores/auth/auth_store.dart';

// stores/form_error
export 'src/stores/form_error/form_error_store.dart';

// stores/location
export 'src/stores/location/location_store.dart';

// stores/navigation
export 'src/stores/navigation/navigation_store.dart';

// stores/sync
export 'src/stores/sync/sync_store.dart';

// utils:-----------------------------------------------------------------------

export 'src/utils/address_autocomplete_utils.dart';
export 'src/utils/location_utils.dart';
export 'src/utils/date_time_utils.dart';
export 'src/utils/device_info_utils.dart';
export 'src/utils/device_utils.dart';
export 'src/utils/dialog_utils.dart';
export 'src/utils/email_validator.dart';
export 'src/utils/file_utils.dart';
export 'src/utils/image_utils.dart';
export 'src/utils/loader_utils.dart';
export 'src/utils/local_db_utils.dart';
export 'src/utils/local_notification_utils.dart';
export 'src/utils/markdown_utils.dart';
export 'src/utils/number_formatter_utils.dart';
export 'src/utils/phone_validator.dart';
export 'src/utils/price_calculator_utils.dart';
export 'src/utils/string_utils.dart';
export 'src/utils/uuid_utils.dart';
export 'src/utils/phone_utils.dart';
export 'src/utils/stream_transformer_utils.dart';
export 'src/utils/stream_utils.dart';
