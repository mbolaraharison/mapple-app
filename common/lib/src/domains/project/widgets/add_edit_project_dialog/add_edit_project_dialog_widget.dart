import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditProjectDialogWidgetInterface implements Widget {
  AddEditProjectDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class AddEditProjectDialogProps {
  const AddEditProjectDialogProps({
    this.order,
    required this.customerId,
    this.customerViewStore,
  });

  final Order? order;
  final String customerId;
  final CustomerViewStoreInterface? customerViewStore;
}

// Implementation:--------------------------------------------------------------
class AddEditProjectDialog extends StatefulWidget
    implements AddEditProjectDialogWidgetInterface {
  const AddEditProjectDialog({super.key, required this.props});

  @override
  final AddEditProjectDialogProps props;

  @override
  State<AddEditProjectDialog> createState() => _AddEditProjectDialogState();
}

class _AddEditProjectDialogState extends State<AddEditProjectDialog> {
  // Stores:--------------------------------------------------------------------
  late final AddEditProjectDialogStoreInterface _store =
      getIt<AddEditProjectDialogStoreInterface>(
    param1: AddEditProjectDialogStoreParams(
      order: widget.props.order,
      customerId: widget.props.customerId,
      customerViewStore: widget.props.customerViewStore,
    ),
  );

  // Navigators:----------------------------------------------------------------
  final AddEditProjectNavigatorInterface _addEditProjectNavigator =
      getIt<AddEditProjectNavigatorInterface>();

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
            key: _addEditProjectNavigator.key,
            initialRoute: _addEditProjectNavigator.addEditInfos,
            onGenerateRoute: _addEditProjectNavigator.onGenerateRoute,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }
}
