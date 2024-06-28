import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class BusinessMonitoringScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class BusinessMonitoringScreen extends StatefulWidget
    implements BusinessMonitoringScreenInterface {
  const BusinessMonitoringScreen({super.key});

  @override
  State<BusinessMonitoringScreen> createState() =>
      _BusinessMonitoringScreenState();
}

class _BusinessMonitoringScreenState extends State<BusinessMonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        headerTitle: 'business_monitoring_title'.tr(),
        child: const Center(child: Text('test')),
      ),
    );
  }
}
