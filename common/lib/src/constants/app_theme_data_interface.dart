import 'package:flutter/cupertino.dart';

abstract class AppThemeDataInterface {
  CupertinoThemeData get themeData;

  Color get defaultTextColor;

  Color get activeMenuColor;

  Color get agencyModeCardColor;

  Color get fairModeCardColor;

  Color get individualCustomerColor;

  Color get professionalCustomerColor;

  Color get topBarButtonColor;

  Color get buttonColor;

  Color get activeSwitchButtonColor;

  Color get avatarDefaultBgColor;

  Color get cartBannerColor;

  Color get cartBannerTextColor;

  Color get dialogHeaderSideTextColor;

  Color get cartFinalizationDateContentsColor;

  Color get cartFinalizationTotalsColor;

  Color get cartFinalizationAvatarBgColor;

  Color get cartFinalizationAvatarInitialsColor;

  Color get cartOrderTotalColor;

  Color get cartPaymentTotalColor;

  Color get repCustomersColor;

  Color get repOtherCustomersColor;

  Color get serviceListingItemColor;

  Color get serviceFloatingButtonColor;

  Color get cartItemsQuantity;

  Color get viewProjectDateBackgroundColor;

  Color get infoTextColor;

  Color get orderFormTitleBannerColor;

  Color get cartLoaderPrimaryColor;

  Color get cartLoaderSecondaryColor;

  // SiteSheet:-----------------------------------------------------------------
  String get siteSheetLogoImage;

  Color get siteSheetPrimaryColor;

  Color get siteSheetSecondaryColor;

  // RepresentativeAppraisal:---------------------------------------------------
  Color get appraisalActiveTabColor;

  Color get appraisalNextButtonColor;

  Color get appraisalPreviousButtonColor;

  Color get representativeAppraisalFormPrimaryColor;

  Color get representativeAppraisalFormSecondaryColor;
}
