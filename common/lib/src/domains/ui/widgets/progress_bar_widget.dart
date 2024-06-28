import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ProgressBarWidgetInterface implements Widget {
  ProgressBarProps get props;

  static final progressBarDefaultDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        getIt<AppThemeDataInterface>().cartLoaderPrimaryColor,
        getIt<AppThemeDataInterface>().cartLoaderSecondaryColor,
      ],
    ),
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(2),
      bottomRight: Radius.circular(2),
    ),
  );
}

// Props:-----------------------------------------------------------------------
class ProgressBarProps {
  ProgressBarProps({
    required this.width,
    required this.percentage,
    this.height = 4,
    BoxDecoration? decoration,
  }) {
    this.decoration =
        decoration ?? ProgressBarWidgetInterface.progressBarDefaultDecoration;
  }

  final double width;
  final double percentage;
  late final BoxDecoration decoration;
  final double height;
}

// Implementation:--------------------------------------------------------------
class ProgressBar extends StatefulWidget implements ProgressBarWidgetInterface {
  const ProgressBar({super.key, required this.props});

  @override
  final ProgressBarProps props;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    final double progressWidth = widget.props.width * widget.props.percentage;

    return AnimatedContainer(
      width: progressWidth,
      height: widget.props.height,
      decoration: widget.props.decoration,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
}
