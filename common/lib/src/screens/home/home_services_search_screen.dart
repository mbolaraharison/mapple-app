import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class HomeServicesSearchScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class HomeServicesSearchScreen extends StatelessWidget
    implements HomeServicesSearchScreenInterface {
  const HomeServicesSearchScreen({super.key});

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        headerWithBackButton: true,
        headerTitle: 'services_search.title'.tr(),
        child: Expanded(
          child: getIt<ServicesSearchWidgetInterface>(
            param1: ServicesSearchProps(),
          ),
        ),
      ),
    );
  }
}
