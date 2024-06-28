import 'package:europe_energie_app/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:europe_energie_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

class AppThemeData implements AppThemeDataInterface {
  @override
  final Color defaultTextColor = AppColors.blueDarkest;

  @override
  final Color activeMenuColor = AppColors.purple;

  @override
  final Color agencyModeCardColor = AppColors.purple;

  @override
  final Color fairModeCardColor = AppColors.blueSecondary;

  @override
  final Color individualCustomerColor = AppColors.blue;

  @override
  final Color professionalCustomerColor = MapleCommonColors.red;

  @override
  final Color topBarButtonColor = AppColors.purple;

  @override
  final Color buttonColor = AppColors.purple;

  @override
  final Color activeSwitchButtonColor = AppColors.purple;

  @override
  final Color avatarDefaultBgColor = AppColors.blueSecondary;

  @override
  final Color cartBannerColor = AppColors.blueSecondary;

  @override
  final Color cartBannerTextColor = Colors.white;

  @override
  final Color dialogHeaderSideTextColor = AppColors.blueModal;

  @override
  final Color cartFinalizationDateContentsColor = AppColors.purple;

  @override
  final Color cartFinalizationTotalsColor = AppColors.purple;

  @override
  final Color cartFinalizationAvatarBgColor = AppColors.yellow;

  @override
  final Color cartFinalizationAvatarInitialsColor = Colors.white;

  @override
  final Color cartOrderTotalColor = AppColors.purple;

  @override
  final Color cartPaymentTotalColor = AppColors.purple;

  @override
  final Color repCustomersColor = AppColors.yellow;

  @override
  final Color repOtherCustomersColor = AppColors.pink;

  @override
  final Color serviceListingItemColor = AppColors.blueSecondary;

  @override
  final Color serviceFloatingButtonColor = AppColors.blueSecondary;

  @override
  final Color cartItemsQuantity = AppColors.blueSecondary;

  @override
  final Color viewProjectDateBackgroundColor = AppColors.purple;

  @override
  final Color orderFormTitleBannerColor = AppColors.blueSecondary;

  @override
  final Color cartLoaderPrimaryColor = AppColors.purple;

  @override
  final Color cartLoaderSecondaryColor = AppColors.purple;

  @override
  Color get infoTextColor => AppColors.blueLight;

  @override
  CupertinoThemeData get themeData => CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            inherit: false,
            fontFamily: '.SF Pro Text',
            fontSize: 17.0,
            letterSpacing: -0.41,
            color: AppColors.blueDark,
            decoration: TextDecoration.none,
          ),
        ),
      );

  // SiteSheet:-----------------------------------------------------------------
  @override
  final String siteSheetLogoImage = Assets.logoWithText;

  @override
  final Color siteSheetPrimaryColor = AppColors.purple;

  @override
  final Color siteSheetSecondaryColor = AppColors.blueSecondary;

  // RepresentativeAppraisal:---------------------------------------------------
  @override
  final Color appraisalActiveTabColor = AppColors.purple;

  @override
  final Color appraisalNextButtonColor = AppColors.purple;

  @override
  final Color appraisalPreviousButtonColor = AppColors.black;

  @override
  final Color representativeAppraisalFormPrimaryColor = AppColors.blueSecondary;

  @override
  final Color representativeAppraisalFormSecondaryColor = AppColors.purple;
}
