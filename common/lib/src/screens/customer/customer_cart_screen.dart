import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerCartScreenInterface implements Widget {
  CustomerCartScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class CustomerCartScreen extends StatefulWidget
    implements CustomerCartScreenInterface {
  // Constructor:---------------------------------------------------------------
  const CustomerCartScreen({super.key, required this.arguments});

  // Properties:----------------------------------------------------------------
  @override
  final CustomerCartScreenArguments arguments;

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Utils:---------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  final _navigatorKey = GlobalKey<NavigatorState>();

  late ReactionDisposer activeStepChangeDisposer;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    widget.arguments.customerOrderStore.initStep();
    widget.arguments.customerOrderStore.paymentStepStore
        .checkIntermediatePaymentCompatibility();
    activeStepChangeDisposer =
        reaction((_) => widget.arguments.customerOrderStore.activeStep, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onActiveStepChange();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final Customer? customer =
            widget.arguments.customerOrderStore.order.customer;
        if (customer == null) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        final availableWidth =
            (MediaQuery.of(context).size.width - SidebarWidgetInterface.width);

        return getIt<MainLayoutWidgetInterface>(
            param1: MainLayoutProps(
          headerTitle: customer.name,
          disabledHeader: true,
          padding: EdgeInsets.zero,
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17, left: 35, right: 35),
                  child: getIt<HeaderWidgetInterface>(
                    param1: HeaderProps(
                      title: customer.name,
                      withBackButton: true,
                      rightChild: _buildHeaderActions(),
                      withSeparator: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 62,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: _appThemeData.cartBannerColor,
                        child: Observer(builder: (_) {
                          return Wrap(
                            spacing: 43,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              _buildStep(1, 'cart.order'.tr()),
                              _buildStep(2, 'cart.payment'.tr()),
                              _buildStep(3, 'cart.finalization.title'.tr()),
                              _buildStep(4, 'cart.signature'.tr()),
                            ],
                          );
                        }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 58),
                        child: Observer(builder: (_) {
                          return getIt<ProgressBarWidgetInterface>(
                            param1: ProgressBarProps(
                              width: availableWidth,
                              percentage: widget
                                  .arguments.customerOrderStore.percentage,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                MultiProvider(
                  providers: [
                    Provider.value(value: widget.arguments.customerOrderStore),
                    Provider.value(
                        value: (context) => _showDatesErrorDialog(context)),
                  ],
                  child: Expanded(
                    child: Navigator(
                      key: _navigatorKey,
                      initialRoute: getIt<CartNavigatorInterface>().cartOrder,
                      onGenerateRoute:
                          getIt<CartNavigatorInterface>().onGenerateRoute,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeaderActions() {
    return Observer(builder: (_) {
      List<Widget> children = [];

      if (widget.arguments.customerOrderStore.activeStep == 1 &&
          !widget.arguments.customerOrderStore.order.isReadonly) {
        children.addAll([
          CupertinoButton(
            onPressed: _onAddServiceTap,
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(
              MapleCommonAssets.plus,
              width: 30,
              colorFilter: ColorFilter.mode(
                _appThemeData.topBarButtonColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          CupertinoButton(
            onPressed:
                widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                    ? _onDiscountTap
                    : null,
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(
              MapleCommonAssets.labelCircle,
              width: 33,
              colorFilter: ColorFilter.mode(
                widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                    ? _appThemeData.topBarButtonColor
                    : CupertinoColors.inactiveGray,
                BlendMode.srcIn,
              ),
            ),
          ),
          CupertinoButton(
            onPressed:
                widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                    ? _onSupplierTap
                    : null,
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(
              MapleCommonAssets.userAdd,
              width: 33,
              colorFilter: ColorFilter.mode(
                widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                    ? _appThemeData.topBarButtonColor
                    : CupertinoColors.inactiveGray,
                BlendMode.srcIn,
              ),
            ),
          ),
          CupertinoButton(
            onPressed:
                widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                    ? _onShowQuoteForm
                    : null,
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.paperplane,
              color:
                  widget.arguments.customerOrderStore.order.orderRows.isNotEmpty
                      ? _appThemeData.topBarButtonColor
                      : CupertinoColors.inactiveGray,
              size: 33,
            ),
          ),
        ]);
      }

      // If the order is not readonly -> display the button for preview the order form
      // If the order is readonly and has an orderFomFileDataId -> display the button for display the order form
      // If the order is readonly and has no orderFomFileDataId -> don't display the button (orders from Sage)
      if (widget.arguments.customerOrderStore.activeStep == 4 &&
          (!widget.arguments.customerOrderStore.order.isReadonly ||
              widget.arguments.customerOrderStore.order.orderFormFileDataId !=
                  null)) {
        children.add(
          CupertinoButton(
            onPressed: _onOrderFormTap,
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.arrow_down_doc_fill,
              color: _appThemeData.topBarButtonColor,
              size: 26,
            ),
          ),
        );
      }

      // Show save button for payment step if active step is payment and step is after payment
      if (widget.arguments.customerOrderStore.step > 2 &&
          widget.arguments.customerOrderStore.activeStep == 2 &&
          widget.arguments.customerOrderStore.order.status == OrderStatus.Z) {
        children.add(
          CupertinoButton(
            onPressed: _onSavePaymentTap,
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.floppy_disk,
              color: widget
                      .arguments.customerOrderStore.paymentStepStore.hasChanges
                  ? _appThemeData.topBarButtonColor
                  : CupertinoColors.inactiveGray,
              size: 26,
            ),
          ),
        );
      }

      if (!widget.arguments.customerOrderStore.order.isReadonly &&
          widget.arguments.customerOrderStore.step != 4 &&
          widget.arguments.customerOrderStore.activeStep ==
              widget.arguments.customerOrderStore.step) {
        children.add(
          SizedBox(
            width: 60,
            child: CupertinoButton(
              onPressed: widget.arguments.customerOrderStore.canGoNext
                  ? _onNextPressed
                  : null,
              padding: EdgeInsets.zero,
              child: Text(
                'next'.tr(),
                style: TextStyle(
                  fontWeight: widget.arguments.customerOrderStore.canGoNext
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: widget.arguments.customerOrderStore.canGoNext
                      ? _appThemeData.topBarButtonColor
                      : CupertinoColors.inactiveGray,
                ),
              ),
            ),
          ),
        );
      }

      return Wrap(
        spacing: 20,
        children: children,
      );
    });
  }

  Widget _buildStep(int number, String label) {
    final bool isActive =
        widget.arguments.customerOrderStore.activeStep == number;
    final bool isDone = widget.arguments.customerOrderStore.step > number ||
        widget.arguments.customerOrderStore.order.isReadonly;
    final bool isCurrent = widget.arguments.customerOrderStore.step == number;

    return CupertinoButton(
      onPressed: number <= widget.arguments.customerOrderStore.step
          ? () {
              widget.arguments.customerOrderStore.setActiveStep(
                value: number,
                context: context,
              );
            }
          : null,
      child: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isActive || isDone
                  ? _appThemeData.cartBannerTextColor
                  : (isCurrent ? CupertinoColors.activeOrange : null),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive || isDone
                    ? _appThemeData.cartBannerTextColor
                    : (isCurrent
                        ? CupertinoColors.activeOrange
                        : CupertinoColors.white),
                width: 1,
              ),
            ),
            child: Center(
              child: isActive || !isDone
                  ? Text(
                      number.toString(),
                      style: TextStyle(
                        color: !isDone && !isActive
                            ? _appThemeData.cartBannerTextColor
                            : _appThemeData.cartBannerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Icon(
                      CupertinoIcons.check_mark,
                      color: _appThemeData.cartBannerColor,
                      size: 14,
                    ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isDone
                  ? _appThemeData.cartBannerTextColor
                  : CupertinoColors.white,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _showDatesErrorDialog(BuildContext context) {
    String content = '';
    if (!widget.arguments.customerOrderStore.finalizationStepStore
        .isInstallAtUpToDate) {
      content = 'cart.finalization.dates.error.installation_date'.tr();
    }
    if (!widget.arguments.customerOrderStore.finalizationStepStore
        .isEndProjectAtUpToDate) {
      if (content != '') {
        content += '\n';
      }
      content += 'cart.finalization.dates.error.project_end_date'.tr();
    }
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('cart.finalization.dates.error.title'.tr()),
        content: Text(
          content,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              widget.arguments.customerOrderStore.signatureStepStore
                  .resetSignatureStep();
            },
            child: Text('ok'.tr()),
          )
        ],
      ),
    );
  }

  void _onDiscountTap() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Provider<CustomerOrderStoreInterface>(
        create: (_) => widget.arguments.customerOrderStore,
        child: getIt<DiscountDialogWidgetInterface>(),
      ),
    );
  }

  void _onSupplierTap() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<SuppliersDialogWidgetInterface>(
        param1: SuppliersDialogProps(
            customerOrderStore: widget.arguments.customerOrderStore),
      ),
    );
  }

  void _onAddServiceTap() {
    Navigator.of(context).pushNamed(
      _customerTabNavigator.servicesRoute,
      arguments: CustomerServicesScreenArguments(
        customerOrderStore: widget.arguments.customerOrderStore,
      ),
    );
  }

  void _onShowQuoteForm() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => getIt<SendQuoteDialogWidgetInterface>(
        param1: SendQuoteDialogProps(
            customerOrderStore: widget.arguments.customerOrderStore),
      ),
    );
  }

  void _onNextPressed() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      await widget.arguments.customerOrderStore.setNextStep(context);
    } on ValidationException catch (e) {
      _showErrorDialog(e.message);
    }
  }

  Future<void> _onOrderFormTap() async {
    _loaderUtils.startLoading(context);
    List<Representative> repValues =
        widget.arguments.customerOrderStore.finalizationStepStore.selectedReps;
    try {
      await getIt<OrderFormGeneratorInterface>().generate(
        repValues: repValues,
        order: widget.arguments.customerOrderStore.order,
        openFile: true,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: '${'order_form.generate_errors.message'.tr()} $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: CupertinoColors.destructiveRed,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
      rethrow;
    } finally {
      if (mounted) {
        _loaderUtils.stopLoading(context);
      }
    }
  }

  void _showErrorDialog(String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('error_title').tr(),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text('ok').tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _onActiveStepChange() {
    final cartStatus =
        CartStatus.fromStep(widget.arguments.customerOrderStore.activeStep);
    _navigatorKey.currentState?.pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          cartStatus.widget,
      transitionDuration: const Duration(seconds: 0),
    ));
  }

  void _onSavePaymentTap() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      await widget.arguments.customerOrderStore.paymentStepStore.save(context);
    } on ValidationException catch (e) {
      _showErrorDialog(e.message);
    }
  }

  // Dispose methods:----------------------------------------------------------
  @override
  void dispose() {
    activeStepChangeDisposer();
    super.dispose();
  }
}
