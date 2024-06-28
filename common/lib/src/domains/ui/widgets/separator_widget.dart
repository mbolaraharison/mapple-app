import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class SeparatorWidgetInterface implements Widget {
  SeparatorProps get props;
}

// Props:-----------------------------------------------------------------------
class SeparatorProps {
  const SeparatorProps({
    this.color = CupertinoColors.opaqueSeparator,
    this.height = .5,
  });

  final Color color;
  final double height;
}

// Implementation:--------------------------------------------------------------
class Separator extends StatelessWidget implements SeparatorWidgetInterface {
  const Separator({
    super.key,
    SeparatorProps? props,
  }) : props = props ?? const SeparatorProps();

  @override
  final SeparatorProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: props.height,
      color: props.color,
    );
  }
}
