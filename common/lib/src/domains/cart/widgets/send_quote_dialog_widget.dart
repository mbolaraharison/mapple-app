import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class SendQuoteDialogWidgetInterface implements Widget {
  SendQuoteDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class SendQuoteDialogProps {
  const SendQuoteDialogProps({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Theme:-----------------------------------------------------------------------
abstract class SendQuoteDialogThemeInterface {
  Color get avatarBgColor;
  Color get addButtonColor;
  Color get avatarNameColor;
  Color get sendButtonColor;
}

// Implementation:--------------------------------------------------------------
class SendQuoteDialog extends StatefulWidget
    implements SendQuoteDialogWidgetInterface {
  // Constructor:---------------------------------------------------------------
  const SendQuoteDialog({super.key, required this.props});

  @override
  final SendQuoteDialogProps props;

  @override
  State<SendQuoteDialog> createState() => _SendQuoteDialogState();
}

class _SendQuoteDialogState extends State<SendQuoteDialog> {
  // Utils methods:-------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final SendQuoteDialogThemeInterface _theme =
      getIt<SendQuoteDialogThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => getIt<DialogWrapperWidgetInterface>(
        param1: DialogWrapperProps(
          width: 500,
          height: 370,
          header: _buildDialogHeader(context),
          child: _buildContent(context),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildDialogHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'close'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          'quote.make.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(builder: (_) {
          return CupertinoButton(
            onPressed: widget.props.customerOrderStore.finalizationStepStore
                    .canGenerateQuote
                ? () => _onGenerateQuote(context)
                : null,
            child: Text(
              'quote.make.display-button'.tr(),
              style: widget.props.customerOrderStore.finalizationStepStore
                      .canGenerateQuote
                  ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                  : const TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _onGenerateQuote(BuildContext context,
      {bool withSave = false}) async {
    _loaderUtils.startLoading(context);
    try {
      await getIt<OrderFormGeneratorInterface>().generateQuote(
        order: widget.props.customerOrderStore.order,
        withSave: withSave,
      );

      if (withSave) {
        Fluttertoast.showToast(
            msg: 'quote.make.confirm-send'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      rethrow;
    } finally {
      if (context.mounted) {
        _loaderUtils.stopLoading(context);
      }
    }
  }

  Widget _buildContent(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime nowAfter15days =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 16));
    if (widget.props.customerOrderStore.finalizationStepStore.installAt ==
        null) {
      widget.props.customerOrderStore.finalizationStepStore
          .setInstallationAt(nowAfter15days);
    }
    if (widget.props.customerOrderStore.finalizationStepStore.installAt
            ?.isBefore(nowAfter15days) ==
        true) {
      widget.props.customerOrderStore.finalizationStepStore
          .setInstallationAt(nowAfter15days);
    }
    return Observer(
      builder: (_) => Column(
        children: [
          const SizedBox(height: 20),
          getIt<DateInputWidgetInterface>(
            param1: DateInputProps(
              label: 'quote.make.installation_date'.tr(),
              value: widget
                  .props.customerOrderStore.finalizationStepStore.installAt,
              minimumDate: nowAfter15days,
              mode: CupertinoDatePickerMode.date,
              onDateChanged: (value) => {
                widget.props.customerOrderStore.finalizationStepStore
                    .setInstallationAt(value),
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildContacSelector(),
          const SizedBox(height: 20),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildContacSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'cart.finalization.customer_signatory'.tr(),
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        FutureBuilder(
            future: widget.props.customerOrderStore.finalizationStepStore
                .selectedContacts,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return Container();
              }

              return getIt<SelectCustomerSignatoriesWidgetInterface>(
                param1: SelectCustomerSignatoriesProps(
                  customerOrderStore: widget.props.customerOrderStore,
                  list: snapshot.data,
                  avatarBgColor: _theme.avatarBgColor,
                  addButtonColor: _theme.addButtonColor,
                  avatarInitialsColor:
                      CupertinoColors.secondarySystemBackground,
                  avatarNameColor: _theme.avatarNameColor,
                  padding: const EdgeInsets.only(left: 16.0),
                  onAvatarPressed: _showEditCustomerContactModalPopup,
                  onEditPressed: _showCustomerContactModalPopup,
                ),
              );
            }),
      ],
    );
  }

  Widget _buildSendButton() {
    return Observer(builder: (_) {
      return SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              color: _theme.sendButtonColor,
              onPressed: widget.props.customerOrderStore.finalizationStepStore
                              .installAt !=
                          null &&
                      widget.props.customerOrderStore.finalizationStepStore
                          .selectedContactValues.isNotEmpty
                  ? () => _onGenerateQuote(context, withSave: true)
                  : null,
              child: Text('quote.make.send-button'.tr()),
            )
          ],
        ),
      );
    });
  }

  void _showEditCustomerContactModalPopup(SelectForSignatureBaseModel contact) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Provider(
        create: (_) => widget.props.customerOrderStore,
        child: getIt<DialogWrapperWidgetInterface>(
          param1: DialogWrapperProps(
            width: 540,
            height: 592,
            disableContentWrapper: true,
            child: getIt<CartCreateOrEditContactWidgetInterface>(
              param1: CartCreateOrEditContactArguments(
                contact: contact as Contact,
                customer: widget.props.customerOrderStore.order.customer!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomerContactModalPopup() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          getIt<CartFinalizationAddContactDialogWidgetInterface>(
        param1: CartFinalizationAddContactDialogProps(
          customerOrderStore: widget.props.customerOrderStore,
        ),
      ),
    );
  }
}
