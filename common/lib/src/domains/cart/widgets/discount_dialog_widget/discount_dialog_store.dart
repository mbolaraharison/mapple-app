import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'discount_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class DiscountDialogStoreInterface {
  DiscountDialogStoreInterface._(
    this.discountType,
    this.commercialAdvantage,
    this.discountCode,
    this.isFirstStepValidated,
    this.selectedRows,
    this.rows,
  );

  // Variables
  DiscountTypeChoice discountType;
  String commercialAdvantage;
  String discountCode;
  DiscountCode? selectedDiscountCode;
  bool isFirstStepValidated;
  ObservableList<OrderRow> selectedRows;
  List<OrderRow> rows;

  // Computed
  bool get isCommercialAdvantageValid;
  bool get isDiscountCodeValid;
  bool get isFirstStepValid;
  bool get formIsValid;
  double get totalNetInclTax;
  String get formattedTotalNetInclTax;

  // Methods
  void setDiscountType(DiscountTypeChoice value);
  void setCommercialAdvantage(String value);
  void setDiscountCode(String value);
  Future<void> submitFirstStep();
  void backToFirstStep();
  Future<void> toggleSelectedServices(OrderRow row);
  void setRows(List<OrderRow> rows);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class DiscountDialogStore = _DiscountDialogStoreBase with _$DiscountDialogStore;

abstract class _DiscountDialogStoreBase
    with Store
    implements DiscountDialogStoreInterface {
  // Services:------------------------------------------------------------------
  final DiscountCodeServiceInterface _discountCodesService =
      getIt<DiscountCodeServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  DiscountTypeChoice discountType = DiscountTypeChoice.commercialAdvantage;

  @override
  @observable
  String commercialAdvantage = '';

  @override
  @observable
  String discountCode = '';

  @override
  @observable
  DiscountCode? selectedDiscountCode;

  @override
  @observable
  bool isFirstStepValidated = false;

  @override
  @observable
  ObservableList<OrderRow> selectedRows = ObservableList<OrderRow>();

  @override
  @observable
  List<OrderRow> rows = [];

  // Computeds:-----------------------------------------------------------------
  @override
  @computed
  bool get isCommercialAdvantageValid {
    final double? discountPercentageInt = double.tryParse(commercialAdvantage);

    if (discountPercentageInt != null &&
        discountPercentageInt > 0 &&
        discountPercentageInt <= 5) {
      return true;
    }

    return false;
  }

  @override
  @computed
  bool get isDiscountCodeValid {
    if (DiscountCode.codeRegExp.hasMatch(discountCode)) {
      return true;
    }

    return false;
  }

  @override
  @computed
  bool get isFirstStepValid {
    if (discountType == DiscountTypeChoice.commercialAdvantage) {
      return commercialAdvantage.isNotEmpty;
    }

    return discountCode.isNotEmpty;
  }

  @override
  @computed
  bool get formIsValid {
    return selectedRows.isNotEmpty;
  }

  @override
  @computed
  double get totalNetInclTax {
    double total = 0;

    for (final OrderRow row in rows) {
      final int index = selectedRows
          .indexWhere((OrderRow selectedRow) => selectedRow.id == row.id);

      if (index != -1) {
        total += selectedRows[index].totalNetInclTax;
      } else {
        total += row.totalNetInclTax;
      }
    }

    return total;
  }

  @override
  @computed
  String get formattedTotalNetInclTax {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalNetInclTax);
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setDiscountType(DiscountTypeChoice value) {
    discountType = value;
  }

  @override
  @action
  void setCommercialAdvantage(String value) {
    commercialAdvantage = value;
  }

  @override
  @action
  void setDiscountCode(String value) {
    discountCode = value;
  }

  @override
  @action
  Future<void> submitFirstStep() async {
    if (discountType == DiscountTypeChoice.commercialAdvantage &&
        !isCommercialAdvantageValid) {
      throw ValidationException(
          'cart.discounts_dialog.errors.commercial_advantage'.tr());
    }

    if (discountType == DiscountTypeChoice.discountCode) {
      if (!isDiscountCodeValid) {
        throw ValidationException(
            'cart.discounts_dialog.errors.discount_code_invalid'.tr());
      }

      final DiscountCode? discountCode = await _discountCodesService.getByCode(
          this.discountCode, DateTime.now());
      await discountCode?.loadData();

      if (discountCode == null) {
        throw ValidationException(
            'cart.discounts_dialog.errors.discount_code_invalid'.tr());
      }

      if (discountCode.familyIds.isNotEmpty) {
        final List<OrderRow> rows = this.rows.where((OrderRow row) {
          final Service service = row.service!;
          final ServiceSubFamily subFamily = service.subFamily!;

          return discountCode.familyIds.contains(subFamily.familyId);
        }).toList();

        if (rows.isEmpty) {
          throw ValidationException(
              'cart.discounts_dialog.errors.discount_code_invalid'.tr());
        }
      }

      if (discountCode.subFamilyIds.isNotEmpty) {
        final List<OrderRow> rows = this.rows.where((OrderRow row) {
          final Service service = row.service!;

          return discountCode.subFamilyIds.contains(service.subFamilyId);
        }).toList();

        if (rows.isEmpty) {
          throw ValidationException(
              'cart.discounts_dialog.errors.discount_code_invalid'.tr());
        }
      }

      if (discountCode.serviceIds.isNotEmpty) {
        final List<OrderRow> rows = this
            .rows
            .where((OrderRow row) =>
                discountCode.serviceIds.contains(row.serviceId))
            .toList();

        if (rows.isEmpty) {
          throw ValidationException(
              'cart.discounts_dialog.errors.discount_code_invalid'.tr());
        }
      }

      selectedDiscountCode = discountCode;
    }

    isFirstStepValidated = true;
  }

  @override
  @action
  void backToFirstStep() {
    isFirstStepValidated = false;
    selectedRows.clear();
    selectedDiscountCode = null;
  }

  @override
  @action
  Future<void> toggleSelectedServices(OrderRow row) async {
    final int index = selectedRows.indexWhere((OrderRow element) {
      return element.id == row.id;
    });
    if (index == -1) {
      if (discountType == DiscountTypeChoice.commercialAdvantage) {
        row = row.copyWith(
          discount: () => double.parse(commercialAdvantage),
          discountCodeId: () => null,
        );
        await row.loadData(eager: true);
        selectedRows.add(row);
        return;
      }
      // Else discountType == DiscountTypeChoice.discountCode
      row = row.copyWith(
        discount: () =>
            selectedDiscountCode!.getDiscountPercentage(row.totalGrossInclTax),
        discountCodeId: () => selectedDiscountCode!.id,
      );
      await row.loadData(eager: true);
      selectedRows.add(row);
    } else {
      selectedRows.removeAt(index);
    }
  }

  @override
  @action
  void setRows(List<OrderRow> rows) {
    this.rows = rows;
  }
}
