import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class MainAppraisalsScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class MainAppraisalsScreen extends StatelessWidget
    implements MainAppraisalsScreenInterface {
  // Constructor:---------------------------------------------------------------
  MainAppraisalsScreen({super.key});

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _representativeService.getCurrentAsStream(),
      builder: (_, AsyncSnapshot<Representative?> snapshot) {
        if (!snapshot.hasData) {
          return const CupertinoActivityIndicator();
        }
        Representative representative = snapshot.data!;
        return representative.isDirector == true
            ? getIt<DirectorAppraisalAgenciesScreenInterface>()
            : getIt<RepresentativeAppraisalsScreenInterface>(
                param1: RepresentativeAppraisalsScreenArguments(
                  representative: representative,
                  editingRepresentative: representative,
                ),
              );
      },
    );
  }
}
