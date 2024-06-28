import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Interface:-------------------------------------------------------------------
abstract class StagingBannerWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class StagingBanner extends StatelessWidget
    implements StagingBannerWidgetInterface {
  StagingBanner({super.key});

  final bool _isDebug = dotenv.env['IS_STAGING'] == 'true';

  @override
  Widget build(BuildContext context) {
    if (!_isDebug) {
      return Container();
    }
    return const SizedBox.expand(
      child: Banner(
        message: 'STAGING',
        location: BannerLocation.topEnd,
      ),
    );
  }
}
