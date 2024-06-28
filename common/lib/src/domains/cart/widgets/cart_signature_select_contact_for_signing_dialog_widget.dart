import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CartSignatureSelectContactForSigningDialogWidgetInterface
    implements Widget {
  CartSignatureSelectContactForSigningDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CartSignatureSelectContactForSigningDialogProps {
  const CartSignatureSelectContactForSigningDialogProps({
    required this.signers,
    this.onSelect,
    required this.customerOrderStore,
  });

  final List<Signer<SignerModel>> signers;
  final ValueChanged<String>? onSelect;
  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class CartSignatureSelectContactForSigningDialog extends StatelessWidget
    implements CartSignatureSelectContactForSigningDialogWidgetInterface {
  CartSignatureSelectContactForSigningDialog({super.key, required this.props});

  @override
  final CartSignatureSelectContactForSigningDialogProps props;

  // Services:------------------------------------------------------------------
  final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  final OrderServiceInterface _orderService = getIt<OrderServiceInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
        stream: _getOrderAndContactsStream(props.signers).stream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          Order order = snapshot.data!['order'];
          List<Contact> contacts = snapshot.data!['contacts'];
          return getIt<CartAddSelectSignatoryDialogWidgetInterface>(
            param1: CartAddSelectSignatoryDialogProps(
              customerOrderStore: props.customerOrderStore,
              selectedValues: order.envelopeSignedRecipientIds,
              values:
                  _getContactsValue(contacts, order.envelopeSignedRecipientIds),
              modalTitle: 'cart.customer_signatures'.tr(),
              errorModalTitle: 'customer.error_infos.label'.tr(),
              errorModalContent: 'customer.error_infos.content'.tr(),
              errorModalContent2: 'customer.error_infos.content_2'.tr(),
              onSelect: props.onSelect,
              isContact: true,
            ),
          );
        });
  }

  List<SelectForSignatureBaseModel> _getContactsValue(
    List<Contact> contacts,
    List<String> envelopeSignedRecipientIds,
  ) {
    return contacts.asMap().entries.map((e) {
      String recipientId = '${e.key + 1}';
      return e.value.getSignerModel(
        index: e.key,
        withMultipleSigners: contacts.length > 1,
        signed: envelopeSignedRecipientIds.contains(recipientId),
        recipientId: recipientId,
      );
    }).toList();
  }

  StreamController<Map<String, dynamic>> _getOrderAndContactsStream(
      List<Signer<SignerModel>> signers) {
    return getIt<StreamUtilsInterface>()
        .combine<dynamic, Map<String, dynamic>>([
      _contactService.getByIdsAsStream(signers.map((e) => e.model.id).toList()),
      _orderService.getByIdAsStream(props.customerOrderStore.order.id),
    ], (List<dynamic> data) {
      return {
        'contacts': data[0] as List<Contact>,
        'order': data[1] as Order,
      };
    });
  }
}
