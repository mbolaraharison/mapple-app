import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectAgencyWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class SelectAgency extends StatefulWidget
    implements SelectAgencyWidgetInterface {
  const SelectAgency({super.key});

  @override
  State<SelectAgency> createState() => _SelectAgencyState();
}

class _SelectAgencyState extends State<SelectAgency> {
  // Services:------------------------------------------------------------------
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Stores:--------------------------------------------------------------------
  final SelectAgencyStoreInterface _selectAgencyStore =
      getIt<SelectAgencyStoreInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
              future: _representativeService.getCurrent(),
              builder: (_, AsyncSnapshot<Representative?> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                Representative representative = snapshot.data!;
                return FutureBuilder<List<Agency>>(
                  future: _agencyService.getAllByEmail(representative.email),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Agency>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    List<Agency> agencies = snapshot.data!;
                    return _buildSelect(agencies);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Observer(
      builder: (context) {
        return getIt<DialogHeaderWidgetInterface>(
          param1: DialogHeaderProps(
            leftContent: CupertinoButton(
              onPressed: _selectAgencyStore.agencyId != ''
                  ? null
                  : () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.chevron_left,
                    color: _selectAgencyStore.agencyId != ''
                        ? CupertinoColors.inactiveGray
                        : DialogHeaderWidgetInterface
                            .sideDefaultTextStyle.color,
                    size: 22,
                  ),
                  Text(
                    'back'.tr(),
                    style: TextStyle(
                      color: _selectAgencyStore.agencyId != ''
                          ? CupertinoColors.inactiveGray
                          : DialogHeaderWidgetInterface
                              .sideDefaultTextStyle.color,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            middleContent: Text(
              'account.agencies'.tr(),
              style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelect(List<Agency> agencies) {
    List<SelectChoice> choices = [];

    for (Agency agency in agencies) {
      choices.add(SelectChoice(value: agency.id, label: agency.label));
    }

    return Observer(
      builder: (context) {
        return getIt<SelectWidgetInterface<String>>(
          param1: SelectProps<String>(
            value: _selectAgencyStore.currentAgency?.id ?? '',
            loadingValue: _selectAgencyStore.agencyId,
            loadingMessage: 'account.load_data'.tr(),
            onChanged: (value) async {
              _selectAgencyStore.setAgencyId(value!);
              await _selectAgencyStore.loadRepresentativeStore();
            },
            choices: choices,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _selectAgencyStore.dispose();
  }
}
