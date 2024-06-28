import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DialogHeaderWidgetInterface implements Widget {
  DialogHeaderProps get props;

  static final middleDefaultTextStyle = TextStyle(
    color: getIt<DialogHeaderWidgetThemeInterface>().middleDefaultTextColor,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static final sideDefaultTextStyle = TextStyle(
    color: getIt<AppThemeDataInterface>().dialogHeaderSideTextColor,
  );
}

abstract class DialogHeaderWidgetThemeInterface {
  Color get middleDefaultTextColor;
}

// Props:-----------------------------------------------------------------------
class DialogHeaderProps {
  const DialogHeaderProps({
    this.middleContent,
    this.height = 52,
    this.color = CupertinoColors.white,
    this.rightContent,
    this.leftContent,
  });

  final double height;
  final Color color;
  final Widget? middleContent;
  final Widget? leftContent;
  final Widget? rightContent;
}

// Implementation:--------------------------------------------------------------
class DialogHeader extends StatelessWidget
    implements DialogHeaderWidgetInterface {
  const DialogHeader({super.key, DialogHeaderProps? props})
      : props = props ?? const DialogHeaderProps();

  @override
  final DialogHeaderProps props;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (props.leftContent != null) {
      children.add(Container(
        alignment: Alignment.centerLeft,
        child: props.leftContent,
      ));
    }

    if (props.middleContent != null) {
      children.add(DefaultTextStyle(
        style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        child: Center(
          child: props.middleContent,
        ),
      ));
    }

    if (props.rightContent != null) {
      children.add(Container(
          alignment: Alignment.centerRight, child: props.rightContent));
    }

    return Container(
      height: props.height,
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0x4D000000),
            width: 0.0,
          ),
        ),
      ),
      child: Stack(children: children),
    );
  }
}
