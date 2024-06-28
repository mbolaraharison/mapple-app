import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interfaces:------------------------------------------------------------------
abstract class HeaderWidgetInterface implements Widget {
  HeaderProps get props;

  HeaderWidgetThemeInterface get theme;
}

abstract class HeaderWidgetThemeInterface {
  Color get backButtonColor;
  Color get titleLightModeColor;
}

// Props:-----------------------------------------------------------------------
class HeaderProps {
  HeaderProps({
    required this.title,
    this.rightChild,
    this.mode = HeaderMode.light,
    this.withBackButton = false,
    this.withSeparator = true,
    this.padding,
    this.onBackButtonTap,
  });

  final String title;
  final Widget? rightChild;
  final HeaderMode mode;
  final bool withBackButton;
  final bool withSeparator;
  final EdgeInsetsGeometry? padding;
  final void Function(BuildContext context)? onBackButtonTap;
}

// Implementation:--------------------------------------------------------------
class Header extends StatelessWidget implements HeaderWidgetInterface {
  Header({super.key, required this.props});

  @override
  final HeaderProps props;

  @override
  final HeaderWidgetThemeInterface theme = getIt<HeaderWidgetThemeInterface>();

  @override
  Widget build(BuildContext context) {
    Color borderColor = props.mode == HeaderMode.light
        ? MapleCommonColors.greyLighter.withOpacity(.5)
        : CupertinoColors.white.withOpacity(.5);
    Color titleColor = props.mode == HeaderMode.light
        ? theme.titleLightModeColor
        : CupertinoColors.white;

    return Container(
      height: 65,
      decoration: props.withSeparator
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: borderColor),
              ),
            )
          : null,
      padding: props.padding,
      child: Row(
        children: [
          if (props.withBackButton)
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(MapleCommonAssets.backCircle,
                    height: 33,
                    colorFilter: ColorFilter.mode(
                      theme.backButtonColor,
                      BlendMode.srcIn,
                    )),
                onPressed: () => props.onBackButtonTap != null
                    ? props.onBackButtonTap!(context)
                    : Navigator.of(context).pop(),
              ),
            ),
          Expanded(
            child: Text(
              props.title,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
          ),
          props.rightChild ?? Container(),
        ],
      ),
    );
  }
}
