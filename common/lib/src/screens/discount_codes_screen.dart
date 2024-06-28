import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class DiscountCodesScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class DiscountCodesScreen extends StatelessWidget
    implements DiscountCodesScreenInterface {
  // Constructor:---------------------------------------------------------------
  DiscountCodesScreen({super.key});

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final DiscountCodeServiceInterface _discountCodesService =
      getIt<DiscountCodeServiceInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
        stream: _getCurrentRepresentativeAndAllAvailableDiscountCodesAsStream(
                eager: true)
            .stream,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          Representative? representative =
              snapshot.data?['representative'] as Representative?;
          List<DiscountCode>? discountCodes =
              snapshot.data?['discountCodes'] as List<DiscountCode>?;
          final screenWidth = MediaQuery.of(context).size.width;
          return getIt<MainLayoutWidgetInterface>(
            param1: MainLayoutProps(
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              headerTitle: 'discount_codes.title'.tr(),
              headerRightChild: (representative == null ||
                      !representative.isDirector)
                  ? Container()
                  : Row(
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          onPressed: () => _onPressedAddDiscountCode(context),
                          child: SvgPicture.asset(
                            MapleCommonAssets.plus,
                            colorFilter: ColorFilter.mode(
                              _appThemeData.buttonColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
              child: Expanded(
                child: discountCodes != null && discountCodes.isNotEmpty
                    ? GridView.count(
                        childAspectRatio: 1 / .6,
                        crossAxisCount: screenWidth <= 1024 ? 3 : 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: _buildDiscountCodes(
                          representative,
                          context: context,
                          discountCodes: discountCodes,
                        ),
                      )
                    : Container(),
              ),
            ),
          );
        });
  }

  // Widget methods:------------------------------------------------------------
  List<Widget> _buildDiscountCodes(Representative? representative,
      {required BuildContext context,
      required List<DiscountCode> discountCodes}) {
    return discountCodes
        .map(
          (discountCode) => _buildDiscountCode(
            representative,
            context: context,
            discountCode: discountCode,
          ),
        )
        .toList();
  }

  Widget _buildDiscountCode(Representative? representative,
      {required BuildContext context, required DiscountCode discountCode}) {
    final Widget button = CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: CupertinoColors.white,
      disabledColor: CupertinoColors.white,
      onPressed: representative != null &&
              representative.isDirector &&
              discountCode.agencyId != null
          ? () => _onPressedEditDiscountCode(
                context: context,
                discountCode: discountCode,
              )
          : null,
      child: Column(
        children: [
          const Spacer(),
          Text(
            'discount_codes.discount_code_value'.tr(
              namedArgs: {'value': discountCode.formattedDiscount},
            ),
            style: TextStyle(
              color: _appThemeData.defaultTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            discountCode.code,
            style: TextStyle(
              color: _appThemeData.defaultTextColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                discountCode.subject.isNotEmpty
                    ? Text.rich(
                        style: TextStyle(
                          fontSize: 11,
                          color: _appThemeData.defaultTextColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: discountCode.subjectLabel,
                          children: [
                            TextSpan(
                              text: discountCode.subject,
                              style: const TextStyle(
                                color: CupertinoColors.systemBlue,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                if (discountCode.startDate != null &&
                    discountCode.endDate != null)
                  Text(
                    'discount_codes.validity'.tr(
                      namedArgs: {
                        'startDate': discountCode.formattedStartDate,
                        'endDate': discountCode.formattedEndDate,
                      },
                    ),
                    style: TextStyle(
                        color: _appThemeData.defaultTextColor, fontSize: 11),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    if (discountCode.agencyId != null) {
      return button;
    }

    return ClipRect(
      child: Banner(
        color: MapleCommonColors.red,
        message: 'discount_codes.global'.tr(),
        location: BannerLocation.topEnd,
        child: button,
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onPressedAddDiscountCode(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<SaveDiscountCodeDialogWidgetInterface>(),
    );
  }

  void _onPressedEditDiscountCode(
      {required BuildContext context, required DiscountCode discountCode}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<SaveDiscountCodeDialogWidgetInterface>(
        param1: discountCode,
      ),
    );
  }

  StreamController<Map<String, dynamic>>
      _getCurrentRepresentativeAndAllAvailableDiscountCodesAsStream(
          {bool eager = false}) {
    return getIt<StreamUtilsInterface>()
        .combine<dynamic, Map<String, dynamic>>([
      _representativeService.getCurrentAsStream(eager: eager),
      _discountCodesService.getAvailableAsStream(DateTime.now(), eager: eager),
    ], (List<dynamic> data) {
      return {
        'representative': data[0] as Representative?,
        'discountCodes': data[1] as List<DiscountCode>,
      };
    });
  }
}
