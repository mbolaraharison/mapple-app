import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class NavigationBannerWidgetInterface implements Widget {
  NavigationBannerProps get props;
}

// Props:-----------------------------------------------------------------------
class NavigationBannerProps {
  const NavigationBannerProps({
    this.height = 0,
    required this.availableWidth,
    required this.progressBarPercentage,
    required this.children,
  });

  final double height;
  final double availableWidth;
  final double progressBarPercentage;
  final List<Widget> children;
}

// Implementation:--------------------------------------------------------------
class NavigationBanner extends StatelessWidget
    implements NavigationBannerWidgetInterface {
  NavigationBanner({
    super.key,
    required this.props,
  });

  @override
  final NavigationBannerProps props;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: props.height,
          color: _appThemeData.cartBannerColor,
          child: Row(
            children: [
              const Spacer(),
              ...props.children,
              const Spacer(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 58),
          child: getIt<ProgressBarWidgetInterface>(
            param1: ProgressBarProps(
              width: props.availableWidth,
              percentage: props.progressBarPercentage,
            ),
          ),
        ),
      ],
    );
  }
}
