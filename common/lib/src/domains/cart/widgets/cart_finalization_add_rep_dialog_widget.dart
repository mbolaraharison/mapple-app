import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CartFinalizationAddRepDialogWidgetInterface implements Widget {
  CartFinalizationAddRepDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CartFinalizationAddRepDialogProps {
  const CartFinalizationAddRepDialogProps({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class CartFinalizationAddRepDialog extends StatelessWidget
    implements CartFinalizationAddRepDialogWidgetInterface {
  CartFinalizationAddRepDialog({super.key, required this.props});

  @override
  final CartFinalizationAddRepDialogProps props;

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getRepresentatives(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else {
            return Observer(builder: (context) {
              return getIt<CartAddSelectSignatoryDialogWidgetInterface>(
                param1: CartAddSelectSignatoryDialogProps(
                  customerOrderStore: props.customerOrderStore,
                  selectedValues: props.customerOrderStore.finalizationStepStore
                      .selectedRepValues,
                  values: snapshot.data?['representatives'] ?? [],
                  modalTitle: 'rep_label'.tr(),
                  errorModalTitle: 'rep.error_infos.label'.tr(),
                  errorModalContent: 'rep.error_infos.content'.tr(),
                  errorModalContent2: 'rep.error_infos.content_2'.tr(),
                  onChanged: props.customerOrderStore.finalizationStepStore
                      .setSelectedRepValues,
                ),
              );
            });
          }
        });
  }

  // Methods:-------------------------------------------------------------------
  Future<Map<String, dynamic>> _getRepresentatives() async {
    List<Representative> reps =
        await _representativeService.getActiveAndAvailableToSell();
    Representative? rep = await _representativeService.getCurrent();

    return {
      'representatives': reps,
      'currentRepresentative': rep,
    };
  }
}
