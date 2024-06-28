import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddRepresentativeAppraisalDialogWidgetInterface
    implements Widget {
  AddRepresentativeAppraisalDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class AddRepresentativeAppraisalDialogProps {
  const AddRepresentativeAppraisalDialogProps({
    required this.representative,
  });

  final Representative representative;
}

// Implementation:--------------------------------------------------------------
class AddRepresentativeAppraisalDialog extends StatelessWidget
    implements AddRepresentativeAppraisalDialogWidgetInterface {
  AddRepresentativeAppraisalDialog({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final AddRepresentativeAppraisalDialogProps props;

  // Stores:--------------------------------------------------------------------
  final AddRepresentativeAppraisalDialogStoreInterface _store =
      getIt<AddRepresentativeAppraisalDialogStoreInterface>();

  // Navigators:----------------------------------------------------------------
  final AddRepresentativeAppraisalNavigatorInterface _navigator =
      getIt<AddRepresentativeAppraisalNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: MultiProvider(
          providers: [
            Provider.value(value: _store),
            Provider.value(value: props),
          ],
          child: Navigator(
            key: _navigator.key,
            initialRoute: _navigator.home,
            onGenerateRoute: _navigator.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
