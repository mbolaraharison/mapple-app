import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CartSignatureSelectRepForSigningDialogWidgetInterface
    implements Widget {
  CartSignatureSelectRepForSigningDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CartSignatureSelectRepForSigningDialogProps {
  const CartSignatureSelectRepForSigningDialogProps({
    required this.signers,
    this.onSelect,
    required this.customerOrderStore,
  });

  final List<Signer<SignerModel>> signers;
  final ValueChanged<String>? onSelect;
  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class CartSignatureSelectRepForSigningDialog extends StatelessWidget
    implements CartSignatureSelectRepForSigningDialogWidgetInterface {
  CartSignatureSelectRepForSigningDialog({super.key, required this.props});

  @override
  final CartSignatureSelectRepForSigningDialogProps props;

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Representative?>(
      future: _representativeService.getCurrent(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return Observer(builder: (context) {
          return getIt<CartAddSelectSignatoryDialogWidgetInterface>(
            param1: CartAddSelectSignatoryDialogProps(
              customerOrderStore: props.customerOrderStore,
              selectedValues: _getSelectedValues(),
              streamForValues: _getRepsStream(props.signers),
              modalTitle: 'cart.sales_representatives_signatures'.tr(),
              errorModalTitle: 'rep.error_infos.label'.tr(),
              errorModalContent: 'rep.error_infos.content'.tr(),
              errorModalContent2: 'rep.error_infos.content_2'.tr(),
              onSelect: props.onSelect,
            ),
          );
        });
      },
    );
  }

  List<String> _getSelectedValues() {
    return props.signers
        .where(
          (element) => props
              .customerOrderStore.signatureStepStore.envelopeSignedRecipientIds
              .contains(element.signer.recipientId),
        )
        .map((e) => e.signer.recipientId)
        .toList();
  }

  Stream<List<SelectForSignatureBaseModel>> _getRepsStream(
    List<Signer<SignerModel>> signers,
  ) {
    Stream<List<Representative>> representativesStream = _representativeService
        .getByIdsAsStream(signers.map((e) => e.model.id).toList());
    return representativesStream.map((List<Representative> reps) {
      return reps.asMap().entries.map((e) {
        String recipientId = '${e.key + 11}';
        return e.value.getSignerModel(
          index: e.key,
          signed: props
              .customerOrderStore.signatureStepStore.envelopeSignedRecipientIds
              .contains(recipientId),
          recipientId: recipientId,
        );
      }).toList();
    });
  }
}
