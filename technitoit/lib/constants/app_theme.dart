/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your theme, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created theme or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/theme.dart';`
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';
import 'package:technitoit_app/constants/assets.dart';
import 'package:technitoit_app/constants/colors.dart';

class AppThemeData implements AppThemeDataInterface {
  @override
  final Color defaultTextColor = AppColors.black;

  @override
  final Color activeMenuColor = AppColors.orange;

  @override
  final Color agencyModeCardColor = AppColors.orange;

  @override
  final Color fairModeCardColor = AppColors.blueLight;

  @override
  final Color individualCustomerColor = AppColors.blueLight;

  @override
  final Color professionalCustomerColor = AppColors.orange;

  @override
  final Color topBarButtonColor = AppColors.orange;

  @override
  final Color buttonColor = AppColors.orange;

  @override
  final Color activeSwitchButtonColor = AppColors.orange;

  @override
  final Color avatarDefaultBgColor = AppColors.blueSkyLight;

  @override
  final Color cartBannerColor = AppColors.black;

  @override
  final Color cartBannerTextColor = Colors.white;

  @override
  final Color dialogHeaderSideTextColor = AppColors.orange;

  @override
  final Color cartFinalizationDateContentsColor = MapleCommonColors.red;

  @override
  final Color cartFinalizationTotalsColor = MapleCommonColors.red;

  @override
  final Color cartFinalizationAvatarBgColor = Colors.white;

  @override
  final Color cartFinalizationAvatarInitialsColor = AppColors.blueSky;

  @override
  final Color cartOrderTotalColor = MapleCommonColors.red;

  @override
  final Color cartPaymentTotalColor = MapleCommonColors.red;

  @override
  final Color repCustomersColor = AppColors.blueLight;

  @override
  final Color repOtherCustomersColor = AppColors.orange;

  @override
  final Color serviceListingItemColor = AppColors.orange;

  @override
  final Color serviceFloatingButtonColor = AppColors.black;

  @override
  final Color cartItemsQuantity = AppColors.black;

  @override
  final Color viewProjectDateBackgroundColor = AppColors.black;

  @override
  final Color infoTextColor = AppColors.blueLight;

  @override
  final Color orderFormTitleBannerColor = AppColors.orange;

  @override
  final Color cartLoaderPrimaryColor = AppColors.blueMatureLight;

  @override
  final Color cartLoaderSecondaryColor = AppColors.blueSky;

  @override
  CupertinoThemeData get themeData => CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            inherit: false,
            fontFamily: '.SF Pro Text',
            fontSize: 17.0,
            letterSpacing: -0.41,
            color: defaultTextColor,
            decoration: TextDecoration.none,
          ),
        ),
      );

  // SiteSheet:-----------------------------------------------------------------
  @override
  final String siteSheetLogoImage = Assets.logoWithText;

  @override
  final Color siteSheetPrimaryColor = AppColors.orange;

  @override
  final Color siteSheetSecondaryColor = AppColors.blueLight;

  // RepresentativeAppraisal:---------------------------------------------------
  @override
  final Color appraisalActiveTabColor = AppColors.orange;

  @override
  final Color appraisalNextButtonColor = AppColors.orange;

  @override
  final Color appraisalPreviousButtonColor = AppColors.black;

  @override
  final Color representativeAppraisalFormPrimaryColor = AppColors.blueLight;

  @override
  final Color representativeAppraisalFormSecondaryColor = AppColors.orange;
}
