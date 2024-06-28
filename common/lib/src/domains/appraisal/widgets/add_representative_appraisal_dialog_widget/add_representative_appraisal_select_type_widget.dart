import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddRepresentativeAppraisalSelectTypeWidgetInterface
    implements Widget {}

// Implementation:--------------------------------------------------------------
class AddRepresentativeAppraisalSelectType extends StatefulWidget
    implements AddRepresentativeAppraisalSelectTypeWidgetInterface {
  const AddRepresentativeAppraisalSelectType({super.key});

  @override
  State<AddRepresentativeAppraisalSelectType> createState() =>
      _AddRepresentativeAppraisalSelectTypeState();
}

class _AddRepresentativeAppraisalSelectTypeState
    extends State<AddRepresentativeAppraisalSelectType> {
  // Stores:--------------------------------------------------------------------
  late final AddRepresentativeAppraisalDialogStoreInterface _store;

  // Props:---------------------------------------------------------------------
  late AddRepresentativeAppraisalDialogProps _props;

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
        child: Column(
          children: [
            const SizedBox(height: 39),
            _buildSelect(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'back'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          'appraisal.create.type'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildSelect() {
    List<SelectChoice> choices = [];

    for (RepresentativeAppraisalType type
        in RepresentativeAppraisalType.values) {
      if (RepresentativeAppraisalType.maxSeniority[type] == null ||
          (_props.representative.startDate
                  ?.isAfter(RepresentativeAppraisalType.maxSeniority[type]!) ??
              true)) choices.add(SelectChoice(value: type, label: type.label));
    }

    return Observer(
      builder: (_) => getIt<SelectWidgetInterface<RepresentativeAppraisalType>>(
        param1: SelectProps<RepresentativeAppraisalType>(
          value: _store.type,
          onChanged: (value) {
            _store.setType(value!);
          },
          choices: choices,
        ),
      ),
    );
  }
}
