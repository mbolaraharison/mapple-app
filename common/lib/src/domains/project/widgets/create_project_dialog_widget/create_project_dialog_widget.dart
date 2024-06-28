import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CreateProjectDialogWidgetInterface implements Widget {
  CreateProjectDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CreateProjectDialogProps {
  const CreateProjectDialogProps({
    this.store,
    this.routesToPush,
    this.onSelectDuplicateCustomer,
  });

  final CreateProjectDialogStoreInterface? store;
  final List<String>? routesToPush;
  final Function(
      BuildContext context,
      String value,
      CreateProjectNavigatorInterface navigator,
      CreateProjectDialogStoreInterface store)? onSelectDuplicateCustomer;
}

// Implementation:--------------------------------------------------------------
class CreateProjectDialog extends StatefulWidget
    implements CreateProjectDialogWidgetInterface {
  const CreateProjectDialog({
    super.key,
    required this.props,
  });

  @override
  final CreateProjectDialogProps props;

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  // Stores:--------------------------------------------------------------------
  late final CreateProjectDialogStoreInterface _store =
      widget.props.store ?? getIt<CreateProjectDialogStoreInterface>();

  // Navigators:----------------------------------------------------------------
  late final CreateProjectNavigatorInterface _navigator =
      getIt<CreateProjectNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // wait for the dialog to be rendered and then push the necessary routes
    // this is for displaying the correct step in the dialog on back navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_navigator.key.currentState!.mounted) {
        for (String route in widget.props.routesToPush ?? []) {
          _navigator.key.currentState!.pushNamed(
            route,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CreateProjectDialogStoreInterface>.value(value: _store),
        Provider<List<String>?>.value(value: widget.props.routesToPush),
        Provider<
                Function(
                    BuildContext context,
                    String value,
                    CreateProjectNavigatorInterface navigator,
                    CreateProjectDialogStoreInterface store)?>.value(
            value: widget.props.onSelectDuplicateCustomer),
      ],
      child: getIt<DialogWrapperWidgetInterface>(
        param1: DialogWrapperProps(
          width: 640,
          height: 670,
          disableContentWrapper: true,
          child: Navigator(
            key: _navigator.key,
            initialRoute: _navigator.selectTypeRoute,
            onGenerateRoute: _navigator.onGenerateRoute,
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
