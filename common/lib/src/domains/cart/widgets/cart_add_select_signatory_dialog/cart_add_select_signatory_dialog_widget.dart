import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartAddSelectSignatoryDialogWidgetInterface implements Widget {
  CartAddSelectSignatoryDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CartAddSelectSignatoryDialogProps {
  const CartAddSelectSignatoryDialogProps({
    required this.customerOrderStore,
    required this.selectedValues,
    this.values,
    this.streamForValues,
    required this.modalTitle,
    required this.errorModalTitle,
    required this.errorModalContent,
    required this.errorModalContent2,
    this.rightChild,
    this.isContact = false,
    this.limit = 3,
    this.onChanged,
    this.onSelect,
  });

  final CustomerOrderStoreInterface customerOrderStore;
  final List<String> selectedValues;
  final List<SelectForSignatureBaseModel>? values;
  final Stream<List<SelectForSignatureBaseModel>>? streamForValues;
  final String modalTitle;
  final String errorModalTitle;
  final String errorModalContent;
  final String errorModalContent2;
  final Widget? rightChild;
  final bool isContact;
  final int limit;
  final void Function(List<String>)? onChanged;
  final void Function(String)? onSelect;
}

// Implementation:--------------------------------------------------------------
class CartAddSelectSignatoryDialog extends StatelessWidget
    implements CartAddSelectSignatoryDialogWidgetInterface {
  CartAddSelectSignatoryDialog({super.key, required this.props});

  @override
  final CartAddSelectSignatoryDialogProps props;

  // Navigators:----------------------------------------------------------------
  final CartAddSelectSignatoryDialogNavigatorInterface _navigator =
      getIt<CartAddSelectSignatoryDialogNavigatorInterface>();

  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: MultiProvider(
          providers: [
            Provider.value(value: props),
            Provider.value(value: props.customerOrderStore),
          ],
          child: Navigator(
            key: _navigator.key,
            initialRoute: _navigator.selectSignatory,
            onGenerateRoute: _navigator.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
