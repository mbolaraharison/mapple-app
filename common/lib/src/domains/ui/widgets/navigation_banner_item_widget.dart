import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class NavigationBannerItemWidgetInterface implements Widget {
  NavigationBannerItemProps get props;
}

// Props:-----------------------------------------------------------------------
class NavigationBannerItemProps {
  const NavigationBannerItemProps({
    required this.index,
    required this.label,
    this.flex = 1,
    this.numberBgColor,
    this.numberBorderColor,
    this.numberTextColor,
    this.labelTextColor,
    this.labelFontWeight,
    this.checked = false,
    required this.availableWidth,
    required this.progressBarPercentage,
    required this.onPressed,
  });

  final int index;
  final String label;
  final int flex;
  final Color? numberBgColor;
  final Color? numberBorderColor;
  final Color? numberTextColor;
  final Color? labelTextColor;
  final FontWeight? labelFontWeight;
  final bool checked;
  final double availableWidth;
  final double progressBarPercentage;
  final void Function()? onPressed;
}

// Implementation:--------------------------------------------------------------
class NavigationBannerItem extends StatelessWidget
    implements NavigationBannerItemWidgetInterface {
  NavigationBannerItem({
    super.key,
    required this.props,
  });

  @override
  final NavigationBannerItemProps props;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: props.flex,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: props.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: props.numberBgColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: props.numberBorderColor ?? CupertinoColors.white,
                  width: 1,
                ),
              ),
              child: Center(
                child: props.checked == false
                    ? Text(
                        (props.index + 1).toString(),
                        style: TextStyle(
                          color: props.numberTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Icon(
                        CupertinoIcons.check_mark,
                        color: _appThemeData.cartBannerColor,
                        size: 14,
                      ),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                props.label,
                style: TextStyle(
                  color: props.labelTextColor,
                  fontWeight: props.labelFontWeight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
