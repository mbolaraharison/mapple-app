import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:open_filex/open_filex.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceDialogWidgetInterface implements Widget {
  ServiceDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class ServiceDialogProps {
  const ServiceDialogProps({
    this.orderRow,
    required this.service,
    this.customerOrderStore,
  });

  final OrderRow? orderRow;
  final Service service;
  final CustomerOrderStoreInterface? customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class ServiceDialog extends StatefulWidget
    implements ServiceDialogWidgetInterface {
  // Constructor:---------------------------------------------------------------
  const ServiceDialog({
    super.key,
    required this.props,
  });

  @override
  final ServiceDialogProps props;

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  // Variables:-----------------------------------------------------------------
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final ServiceDialogStoreInterface _store;

  // Utils:---------------------------------------------------------------------
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<ServiceDialogStoreInterface>(
      param1: ServiceDialogStoreParams(
        orderRow: widget.props.orderRow,
        service: widget.props.service,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return getIt<DialogWrapperWidgetInterface>(
        param1: DialogWrapperProps(
          width: 712,
          height: 720,
          header: _buildDialogHeader(context),
          child: _buildContent(context),
        ),
      );
    });
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildDialogHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        rightContent: widget.props.customerOrderStore != null
            ? Observer(builder: (_) {
                return CupertinoButton(
                  onPressed: _store.canSubmit ? () => _onSubmit(context) : null,
                  child: Text(
                    _store.isEditing
                        ? 'cart.edit_order_row'.tr()
                        : 'services.add_dialog.add'.tr(),
                    style: _store.canSubmit
                        ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                            .copyWith(fontWeight: FontWeight.w600)
                        : const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                );
              })
            : Container(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMeta(context),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildMeta(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMetaFirstRow(context),
        const SizedBox(height: 30),
        _buildMetaLastRow(),
      ],
    );
  }

  Widget _buildMetaFirstRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _store.service.label,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _store.service.sageId,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            if (_store.service.sheetFileDataId != null)
              CupertinoButton(
                onPressed: () => _openSheetFile(context, _store.service),
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.arrow_down_doc_fill,
                  color: _appThemeData.buttonColor,
                  size: 26,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        getIt<SeparatorWidgetInterface>(),
        const SizedBox(height: 16),
        Row(
          children: [
            _store.service.isMiscellanous == true
                ? Observer(builder: (_) {
                    return Expanded(
                      child: getIt<TextInputWidgetInterface>(
                        param1: TextInputProps(
                          controller: _store
                              .grossPriceWithoutTaxMiscellaneousController,
                          label:
                              '${'services.add_dialog.price_without_vat'.tr()} (${_store.service.getUnitLabel(_store.priceListItem)})',
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9]\d*(\.|,)?\d*'),
                            ),
                          ],
                          onChanged:
                              _store.setGrossPriceWithoutTaxMiscellaneous,
                        ),
                      ),
                    );
                  })
                : Expanded(
                    child: Row(
                      children: [
                        Text(
                          'services.add_dialog.price_without_vat'.tr(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        _buildUnitText(),
                        const Spacer(),
                        Text(
                          _store.formattedUnitPriceWithoutTax,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 10),
        getIt<SeparatorWidgetInterface>(),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'services.add_dialog.price_with_vat'.tr(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            _buildUnitText(),
            const Spacer(),
            Observer(builder: (_) {
              return Text(
                _store.formattedGrossPriceInclTax,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildMetaLastRow() {
    List<Widget> children = [];

    if (_store.service.hasOptions) {
      children.addAll([
        Observer(builder: (_) {
          return getIt<PickerWidgetInterface<ServiceOptionItem?>>(
            param1: PickerProps<ServiceOptionItem?>(
              label: _store.service.optionsCount == 1
                  ? 'services.add_dialog.option_label'.tr()
                  : 'services.add_dialog.option1_label'.tr(),
              value: _store.option1,
              choices: _store.option1Choices,
              onChanged: _store.setOption1,
            ),
          );
        }),
        getIt<SeparatorWidgetInterface>(
          param1: SeparatorProps(
            color: CupertinoColors.opaqueSeparator.withOpacity(.5),
          ),
        ),
      ]);

      if (_store.service.optionsCount == 2) {
        children.addAll([
          Observer(builder: (_) {
            return getIt<PickerWidgetInterface<ServiceOptionItem?>>(
              param1: PickerProps<ServiceOptionItem?>(
                label: 'services.add_dialog.option2_label'.tr(),
                value: _store.option2,
                choices: _store.option2Choices,
                disable: _store.option2isDisabled,
                onChanged: _store.setOption2,
              ),
            );
          }),
          getIt<SeparatorWidgetInterface>(
            param1: SeparatorProps(
              color: CupertinoColors.opaqueSeparator.withOpacity(.5),
            ),
          ),
        ]);
      }
    }

    children.addAll([
      Observer(builder: (_) {
        return getIt<PickerWidgetInterface<TaxLevel>>(
          param1: PickerProps<TaxLevel>(
            label: 'services.add_dialog.tax'.tr(),
            value: _store.taxLevel,
            choices: TaxLevel.pickerChoices,
            onChanged: _store.setTaxLevel,
          ),
        );
      }),
      getIt<SeparatorWidgetInterface>(
        param1: SeparatorProps(
          color: CupertinoColors.opaqueSeparator.withOpacity(.5),
        ),
      ),
      Observer(builder: (_) {
        PriceListUnit? priceListUnit =
            PriceListUnit.fromValue(_store.priceListItem?.unit);
        return getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            controller: _store.quantityController,
            label: 'services.add_dialog.quantity'.tr(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                priceListUnit != null && priceListUnit.acceptsDecimals
                    ? RegExp(r'^[1-9]\d*(\.|,)?\d*')
                    : RegExp(r'^[1-9]\d*'),
              ),
            ],
            onChanged: _store.setQuantity,
          ),
        );
      }),
      getIt<SeparatorWidgetInterface>(
        param1: SeparatorProps(
          color: CupertinoColors.opaqueSeparator.withOpacity(.5),
        ),
      ),
      Observer(builder: (_) {
        return getIt<PickerWidgetInterface>(
          param1: PickerProps(
            label: 'services.add_dialog.unit'.tr(),
            value: _store.selectedUnit,
            choices: _store.unitChoices,
            disable: _store.isUnitSelectDisabled,
            onChanged: (dynamic item) => _store.setUnit(item as String),
          ),
        );
      }),
    ]);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 377,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: children,
          ),
        ),
        Container(
          width: 255,
          height: 88,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
          decoration: BoxDecoration(
            color: _appThemeData.defaultTextColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'services.add_dialog.total'.tr(),
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Observer(builder: (_) {
                  return Text(
                    _store.formattedTotalGrossInclTax,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 27),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Désignation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          _store.service.isMiscellanous == true
              ? getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    height: 240,
                    maxLines: 19,
                    labelWidth: 180,
                    controller: _store.designationController,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    onChanged: _store.setDesignation,
                  ),
                )
              : Text(
                  _store.computedDesignation,
                  style: const TextStyle(fontSize: 13),
                )
        ],
      ),
    );
  }

  _buildUnitText() {
    return Observer(builder: (_) {
      return Text('(${_store.service.getUnitLabel(_store.priceListItem)})',
          style: const TextStyle(fontSize: 15));
    });
  }

  // General methods:-----------------------------------------------------------
  void _onSubmit(BuildContext context) {
    PriceListUnit? priceListUnit =
        PriceListUnit.fromValue(_store.priceListItem?.unit);
    if (priceListUnit == null ||
        (!priceListUnit.acceptsDecimals && _store.quantityValue is double)) {
      getIt<DialogUtilsInterface>().showErrorDialog(
          context: context,
          errorMessage: 'cart.quantity_unit_error'
              .tr(namedArgs: {'unit': _store.priceListItem?.unit ?? ''}));
    } else {
      if (_store.isEditing) {
        _updateOrderRow(context);
      } else {
        _addOrderRow(context);
      }
    }
  }

  void _addOrderRow(BuildContext context) {
    if (widget.props.customerOrderStore == null) {
      return;
    }

    if (widget.props.customerOrderStore!.orderStepStore.orderRows.isNotEmpty) {
      if (_store.service.subFamily!.family!.isEnergyRelated == true &&
          widget.props.customerOrderStore!.orderStepStore.isEnergyRelated ==
              false) {
        Fluttertoast.showToast(
            msg: 'services.add_dialog.no_energy_related_error'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        return;
      }

      if (_store.service.subFamily!.family!.isEnergyRelated == false &&
          widget.props.customerOrderStore!.orderStepStore.isEnergyRelated ==
              true) {
        Fluttertoast.showToast(
            msg: 'services.add_dialog.no_energy_non_related_error'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        return;
      }
    }

    OrderRow orderRow = OrderRow(
      id: _uuidUtils.generate(),
      orderId: widget.props.customerOrderStore!.order.id,
      agencyId: widget.props.customerOrderStore!.order.agencyId,
      serviceId: _store.service.id,
      designation: _store.service.isMiscellanous == true
          ? _store.designation
          : (_store.computedDesignation),
      option1Id: _store.option1?.id,
      option2Id: _store.option2?.id,
      quantity: _store.quantityValue.toDouble(),
      grossPrice: _store.service.isMiscellanous == true
          ? _store.grossPriceWithoutTaxMiscellaneousValue.toDouble()
          : _store.priceListItem!.price.toDouble(),
      unit: _store.service.getUnit(_store.priceListItem),
      taxLevel: _store.taxLevel,
      priceListItemId: _store.service.isMiscellanous == true
          ? null
          : _store.priceListItem!.id,
    );

    widget.props.customerOrderStore!.orderStepStore.addOrderRow(orderRow);

    widget.props.customerOrderStore!.resetCartStatus();

    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: 'services.add_dialog.confirm_add'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _updateOrderRow(BuildContext context) {
    if (widget.props.customerOrderStore == null) {
      return;
    }

    widget.props.orderRow!.option1Id = _store.option1?.id;
    widget.props.orderRow!.option2Id = _store.option2?.id;
    widget.props.orderRow!.taxLevel = _store.taxLevel;
    widget.props.orderRow!.designation = _store.service.isMiscellanous == true
        ? _store.designation
        : _store.computedDesignation;
    widget.props.orderRow!.quantity = _store.quantityValue.toDouble();
    widget.props.orderRow!.grossPrice = _store.service.isMiscellanous == true
        ? _store.grossPriceWithoutTaxMiscellaneousValue.toDouble()
        : _store.priceListItem!.price.toDouble();
    widget.props.orderRow!.priceListItemId =
        _store.service.isMiscellanous == true ? null : _store.priceListItem!.id;
    widget.props.orderRow!.unit = _store.service.getUnit(_store.priceListItem);
    widget.props.orderRow!.updateDiscount();

    widget.props.customerOrderStore!.orderStepStore
        .updateOrderRow(widget.props.orderRow!);

    widget.props.customerOrderStore!.resetCartStatus();

    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: 'cart.edit_order_row_confirm_message'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _openSheetFile(BuildContext context, Service service) async {
    _loaderUtils.startLoading(context);
    if (service.sheetFileDataId == null) {
      return;
    }
    FileData? fileData =
        await _fileDataService.getById(service.sheetFileDataId!);
    if (fileData == null) {
      return;
    }
    File? file =
        await _fileDataService.getFileFromFileSystem(fileData.uniqueName);
    if (file == null) {
      return;
    }
    await OpenFilex.open(file.path);
    if (!context.mounted) return;
    _loaderUtils.stopLoading(context);
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }
}
