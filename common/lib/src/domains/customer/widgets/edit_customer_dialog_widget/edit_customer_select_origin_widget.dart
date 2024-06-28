import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerSelectOriginWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class EditCustomerSelectOrigin extends StatefulWidget
    implements EditCustomerSelectOriginWidgetInterface {
  const EditCustomerSelectOrigin({super.key});

  @override
  State<EditCustomerSelectOrigin> createState() =>
      _EditCustomerSelectOriginState();
}

class _EditCustomerSelectOriginState extends State<EditCustomerSelectOrigin> {
  // Lifecycle methods:---------------------------------------------------------
  late final EditCustomerDialogStoreInterface _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<EditCustomerDialogStoreInterface>(context);
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: _buildSelects(),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: Wrap(
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
        ),
        middleContent: Text(
          'origin.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  List<Widget> _buildSelects() {
    List<Widget> selects = [];

    Map<Origin, List<SelectChoice>> categories = {};

    for (var origin in OriginDetails.detailsByOrigin.entries) {
      List<SelectChoice> choices = [];
      for (var detail in origin.value) {
        choices.add(SelectChoice(
          label: detail.label,
          value: detail,
        ));
      }
      categories[origin.key] = choices;
    }

    for (var category in categories.keys) {
      selects.add(
        Container(
          margin: const EdgeInsets.only(bottom: 17),
          child: Observer(
            builder: (context) {
              return getIt<SelectWidgetInterface<OriginDetails>>(
                param1: SelectProps<OriginDetails>(
                  label: category.label,
                  value: _store.originDetails,
                  onChanged: (value) {
                    _store.setOrigin(category, value!);
                  },
                  choices: categories[category]!,
                ),
              );
            },
          ),
        ),
      );
    }

    return selects;
  }
}
