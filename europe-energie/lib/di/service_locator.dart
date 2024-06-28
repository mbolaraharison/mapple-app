import 'package:europe_energie_app/constants/app_info.dart';
import 'package:europe_energie_app/constants/app_theme.dart';
import 'package:europe_energie_app/data/constants/themes/customer_type_theme.dart';
import 'package:europe_energie_app/data/constants/themes/order_status_theme.dart';
import 'package:europe_energie_app/data/constants/themes/project_status_theme.dart';
import 'package:europe_energie_app/data/dto/themes/order_form_dto_theme.dart';
import 'package:europe_energie_app/domains/cart/widgets/themes/cart_payment_theme.dart';
import 'package:europe_energie_app/domains/cart/widgets/themes/cart_signature_theme.dart';
import 'package:europe_energie_app/domains/cart/widgets/themes/discount_dialog_theme.dart';
import 'package:europe_energie_app/domains/cart/widgets/themes/send_quote_dialog_theme.dart';
import 'package:europe_energie_app/domains/customer/widgets/themes/customers_list_view_theme.dart';
import 'package:europe_energie_app/domains/customer/widgets/themes/select_customer_signatories_theme.dart';
import 'package:europe_energie_app/domains/services/widgets/themes/services_search_screen_theme.dart';
import 'package:europe_energie_app/domains/ui/widgets/themes/dialog/dialog_header_widget_theme.dart';
import 'package:europe_energie_app/domains/ui/widgets/themes/header_widget_theme.dart';
import 'package:europe_energie_app/domains/ui/widgets/themes/sidebar_widget_theme.dart';
import 'package:europe_energie_app/screens/themes/auth/login_screen_theme.dart';
import 'package:europe_energie_app/screens/themes/customer/customer_view_project_screen_theme.dart';
import 'package:europe_energie_app/screens/themes/home_screen_theme.dart';
import 'package:europe_energie_app/screens/themes/main_screen_theme.dart';
import 'package:maple_common/maple_common.dart';

Future<void> setupLocator() async {
  // constants
  getIt.registerSingleton<AppInfoInterface>(AppInfo());
  getIt.registerSingleton<AppThemeDataInterface>(AppThemeData());

  // data

  // -- data/constants

  // ---- data/constants/themes
  getIt.registerLazySingleton<CustomerTypeThemeInterface>(
      () => CustomerTypeTheme());
  getIt.registerLazySingleton<OrderStatusThemeInterface>(
      () => OrderStatusTheme());
  getIt.registerLazySingleton<ProjectStatusThemeInterface>(
      () => ProjectStatusTheme());

  // -- data/dto

  // ---- data/dto/themes
  getIt.registerLazySingleton<OrderFormDtoThemeInterface>(
      () => OrderFormDtoTheme());

  // domains

  // -- domains/cart

  // ---- domains/cart/widgets

  // ------ domains/cart/widgets/themes
  getIt.registerLazySingleton<CartPaymentWidgetThemeInterface>(
      () => CartPaymentTheme());
  getIt.registerLazySingleton<CartSignatureThemeInterface>(
      () => CartSignatureTheme());
  getIt.registerLazySingleton<DiscountDialogThemeInterface>(
      () => DiscountDialogTheme());
  getIt.registerLazySingleton<SendQuoteDialogThemeInterface>(
      () => SendQuoteDialogTheme());

  // -- domains/customer

  // ---- domains/customer/widgets

  // ------ domains/customer/widgets/themes
  getIt.registerLazySingleton<CustomersListViewThemeInterface>(
      () => CustomersListViewTheme());
  getIt.registerLazySingleton<SelectCustomerSignatoriesThemeInterface>(
      () => SelectCustomerSignatoriesTheme());

  // -- domains/services

  // ---- domains/services/widgets

  // ------ domains/services/widgets/themes
  getIt.registerLazySingleton<ServicesSearchScreenThemeInterface>(
      () => ServicesSearchScreenTheme());

  // -- domains/ui

  // ---- domains/ui/themes
  getIt.registerLazySingleton<HeaderWidgetThemeInterface>(
      () => HeaderWidgetTheme());
  getIt.registerLazySingleton<SidebarWidgetThemeInterface>(
      () => SidebarWidgetTheme());

  // ------ domains/ui/themes/dialog
  getIt.registerLazySingleton<DialogHeaderWidgetThemeInterface>(
      () => DialogHeaderWidgetTheme());

  // screens

  // -- screens/themes
  getIt
      .registerLazySingleton<HomeScreenThemeInterface>(() => HomeScreenTheme());
  getIt
      .registerLazySingleton<MainScreenThemeInterface>(() => MainScreenTheme());

  // ---- screens/themes/auth
  getIt.registerLazySingleton<LoginScreenThemeInterface>(
      () => LoginScreenTheme());

  // ---- screens/themes/customer
  getIt.registerLazySingleton<CustomerViewProjectScreenThemeInterface>(
      () => CustomerViewProjectScreenTheme());
}
