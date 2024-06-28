import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddRepresentativeAppraisalHomeWidgetInterface
    implements Widget {}

// Implementation:--------------------------------------------------------------
class AddRepresentativeAppraisalHome extends StatefulWidget
    implements AddRepresentativeAppraisalHomeWidgetInterface {
  const AddRepresentativeAppraisalHome({super.key});

  @override
  State<AddRepresentativeAppraisalHome> createState() =>
      _AddRepresentativeAppraisalHomeState();
}

class _AddRepresentativeAppraisalHomeState
    extends State<AddRepresentativeAppraisalHome> {
  // Stores:--------------------------------------------------------------------
  late AddRepresentativeAppraisalDialogStoreInterface _store;
  late AddRepresentativeAppraisalDialogProps _props;

  // Navigators:----------------------------------------------------------------
  late final AddRepresentativeAppraisalNavigatorInterface _navigator =
      getIt<AddRepresentativeAppraisalNavigatorInterface>();
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Utils:----------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store =
        Provider.of<AddRepresentativeAppraisalDialogStoreInterface>(context);
    _props = Provider.of<AddRepresentativeAppraisalDialogProps>(context);
  }

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Observer(
            builder: (context) {
              return Column(
                children: [
                  getIt<RowButtonWidgetInterface>(
                    param1: RowButtonProps(
                      onPressed: () => _navigator.key.currentState!.pushNamed(
                        _navigator.selectType,
                      ),
                      child: AutoSizeText(
                        'appraisal.create.type'.tr(),
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        minFontSize: 14,
                      ),
                      value: RepresentativeAppraisalType
                          .representativeAppraisalNames[_store.type]!,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      margin: const EdgeInsets.only(bottom: 14),
                      width: double.infinity,
                    ),
                  ),
                  getIt<RowButtonWidgetInterface>(
                    param1: RowButtonProps(
                      child: AutoSizeText(
                        'appraisal.create.limit_date'.tr(),
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      margin: const EdgeInsets.only(bottom: 14),
                      value: _store.formattedLimitDate,
                      onPressed: () => _showLimitDateDialog(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => _rootNavigator.key.currentState?.pop(),
        ),
        middleContent: Text(
          'appraisal.create.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _store.formIsValid ? _submit : null,
              child: Text(
                'add'.tr(),
                style: _store.formIsValid
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        .copyWith(fontWeight: FontWeight.w600)
                    : const TextStyle(
                        color: CupertinoColors.inactiveGray,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLimitDateDialog(BuildContext context) {
    DateTime now = DateTime.now();
    if (_store.limitDate == null || _store.limitDate!.isBefore(now)) {
      _store.setLimitDate(now);
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 216,
        alignment: Alignment.center,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            minimumDate: now,
            initialDateTime: _store.limitDate,
            mode: CupertinoDatePickerMode.date,
            // This is called when the user changes the dateTime.
            onDateTimeChanged: (DateTime newDateTime) {
              _store.setLimitDate(newDateTime);
            },
          ),
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Future<void> _submit() async {
    _loaderUtils.startLoading(context);
    await _store.createRepresentativeAppraisal(_props.representative);
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
    _rootNavigator.key.currentState?.pop();
  }
}
