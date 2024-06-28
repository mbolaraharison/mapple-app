import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RadioWidgetInterface implements Widget {
  RadioProps get props;
}

// Props:-----------------------------------------------------------------------
class RadioProps {
  const RadioProps({
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
}

// Implementation:--------------------------------------------------------------
class Radio extends StatefulWidget implements RadioWidgetInterface {
  const Radio({super.key, required this.props});

  @override
  final RadioProps props;

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState extends State<Radio> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.props.value ? 1.0 : 0.0,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didUpdateWidget(Radio oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.props.value != widget.props.value) _resumeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Icon(
        CupertinoIcons.circle,
        color: MapleCommonColors.greyLighter,
        size: 19,
      ),
      ScaleTransition(
          scale: _animation,
          child: const Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: CupertinoColors.systemBlue,
            size: 19,
          ))
    ];

    if (widget.props.onChanged != null) {
      return CupertinoButton(
          onPressed: () => widget.props.onChanged!(!widget.props.value),
          child: Stack(children: children));
    }

    return Stack(children: children);
  }

  // General methods:-----------------------------------------------------------
  void _resumeAnimation() {
    if (widget.props.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  // Dispose method:------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
