import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ConfigureRepresentativeAppraisalDialogWidgetInterface
    implements Widget {
  Representative get representative;
}

// Implementation:--------------------------------------------------------------
class ConfigureRepresentativeAppraisalDialog extends StatefulWidget
    implements ConfigureRepresentativeAppraisalDialogWidgetInterface {
  const ConfigureRepresentativeAppraisalDialog(
      {super.key, required this.representative});

  // Properties:----------------------------------------------------------------
  @override
  final Representative representative;

  @override
  State<ConfigureRepresentativeAppraisalDialog> createState() =>
      _ConfigureRepresentativeAppraisalDialogState();
}

class _ConfigureRepresentativeAppraisalDialogState
    extends State<ConfigureRepresentativeAppraisalDialog> {
  // Stores:--------------------------------------------------------------------
  late final ConfigureRepresentativeAppraisalDialogStoreInterface _store;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _store = getIt<ConfigureRepresentativeAppraisalDialogStoreInterface>(
      param1: ConfigureRepresentativeAppraisalDialogStoreParams(
        representative: widget.representative,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return getIt<DialogWrapperWidgetInterface>(
          param1: DialogWrapperProps(
            width: 500,
            height: 500,
            header: _buildHeader(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text('appraisal.training_protocol.title'.tr()),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _onSubmit,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: DialogHeaderWidgetInterface.sideDefaultTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          'appraisal.training_protocol.common.title'.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      const SizedBox(height: 10),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value: 'appraisal.arrival_date'.tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color.fromARGB(255, 226, 226, 226),
            ),
            child: Text(
              widget.representative.startDate != null
                  ? DateFormat('MMM yyyy')
                      .format(widget.representative.startDate!)
                  : '',
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemBlue,
              ),
            ),
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.common.probationary_period_validation'
                  .tr(),
          disableOnTapEffect: true,
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.probationaryPeriodValidation,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setProbationaryPeriodValidation,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value: 'appraisal.training_protocol.common.corporate_vehicle'.tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.corporateVehicle,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setCorporateVehicle,
          ),
        ),
      ),
      const SizedBox(height: 20),
      // First base
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          'appraisal.training_protocol.first_base.title'.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      const SizedBox(height: 10),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.first_base.two_months_with_35_40_booked_meetings'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.twoMonthsWith3540BookedMeetings,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setTwoMonthsWith3540BookedMeetings,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.first_base.first_introduction_before_mentor'
                  .tr(),
          disableOnTapEffect: true,
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.firstIntroductionBeforeMentor,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setFirstIntroductionBeforeMentor,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.first_base.two_months_with_15_opportunity_requests'
                  .tr(),
          disableOnTapEffect: true,
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.twoMonthsWith15OpportunityRequests,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setTwoMonthsWith15OpportunityRequests,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.first_base.alone_on_first_sale'.tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.aloneOnFirstSale,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setAloneOnFirstSale,
          ),
        ),
      ),
      const SizedBox(height: 20),
      // Second base
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          'appraisal.training_protocol.second_base.title'.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      const SizedBox(height: 10),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.second_base.first_sale_at_fair'.tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.firstSaleAtFair,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setFirstSaleAtFair,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.second_base.alone_on_4_funding_sales'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.aloneOn4FundingSales,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setAloneOn4FundingSales,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.second_base.two_months_with_20K_turnover'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.twoMonthsWith20KTurnover,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setTwoMonthsWith20KTurnover,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.second_base.alone_on_first_additional_sale'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.aloneOnFirstAdditionalSale,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setAloneOnFirstAdditionalSale,
          ),
        ),
      ),
      const SizedBox(height: 20),
      // Third base
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          'appraisal.training_protocol.third_base.title'.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      const SizedBox(height: 10),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.third_base.alone_on_30K_or_more_turnover_in_one_month'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.aloneOn30KOrMoreTurnoverInOneMonth,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setAloneOn30KOrMoreTurnoverInOneMonth,
          ),
        ),
      ),
      getIt<SeparatorWidgetInterface>(),
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          value:
              'appraisal.training_protocol.third_base.sold_two_products_in_one_sale'
                  .tr(),
          disableOnTapEffect: true,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          valueColor: _appThemeData.defaultTextColor,
          height: 48,
          rightChild: CupertinoSwitch(
            value: _store.soldTwoProductsInOneSale,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: _store.setSoldTwoProductsInOneSale,
          ),
        ),
      ),
    ];
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onSubmit() async {
    try {
      await _store.updateRepresentative();
      if (!mounted) return;
      Navigator.pop(context);
    } on ValidationException catch (e) {
      _showError(e.message);
    }
  }

  void _showError(String errorMessage) {
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

  @override
  void dispose() {
    super.dispose();
  }
}
