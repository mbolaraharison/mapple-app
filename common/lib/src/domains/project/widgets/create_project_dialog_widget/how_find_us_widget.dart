import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class HowFindUsWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class HowFindUs extends StatefulWidget implements HowFindUsWidgetInterface {
  const HowFindUs({super.key});

  @override
  State<HowFindUs> createState() => _HowFindUsState();
}

class _HowFindUsState extends State<HowFindUs> {
  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _createProjectDialogStore;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createProjectDialogStore =
        Provider.of<CreateProjectDialogStoreInterface>(context);
  }

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

  // Widget methods:------------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
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
        ),
        middleContent: Text(
          'home_create_project_dialog_how_find_us'.tr(),
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
                  value: _createProjectDialogStore.customerOriginDetails,
                  onChanged: (value) {
                    _createProjectDialogStore.setOrigin(category, value!);
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
