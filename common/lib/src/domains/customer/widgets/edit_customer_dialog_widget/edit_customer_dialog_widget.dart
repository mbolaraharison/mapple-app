import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerDialogWidgetInterface implements Widget {
  EditCustomerDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class EditCustomerDialogProps {
  const EditCustomerDialogProps({
    required this.customer,
  });

  final Customer customer;
}

// Implementation:--------------------------------------------------------------
class EditCustomerDialog extends StatefulWidget
    implements EditCustomerDialogWidgetInterface {
  const EditCustomerDialog({super.key, required this.props});

  @override
  final EditCustomerDialogProps props;

  @override
  State<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  // Stores:--------------------------------------------------------------------
  late final EditCustomerDialogStoreInterface _store =
      getIt<EditCustomerDialogStoreInterface>(
    param1: EditCustomerDialogStoreParams(
      customer: widget.props.customer,
    ),
  );

  // Navigators:----------------------------------------------------------------
  late final EditCustomerDialogNavigatorInterface _navigator =
      getIt<EditCustomerDialogNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: Provider(
          create: (context) => _store,
          child: Navigator(
            key: _navigator.key,
            initialRoute: _navigator.editInfos,
            onGenerateRoute: _navigator.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
