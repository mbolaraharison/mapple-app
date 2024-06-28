import 'package:flutter/material.dart';

// Interface:-------------------------------------------------------------------
abstract class ShakeWidgetInterface implements Widget {
  ShakeWidgetProps get props;
}

// Props:-----------------------------------------------------------------------
class ShakeWidgetProps {
  ShakeWidgetProps({
    required this.controller,
    this.initialPosition = 0,
    this.finalPosition = 0,
    this.startPosition = 0,
    this.endPosition = 1,
    this.direction = Axis.horizontal,
    this.child,
  });

  final AnimationController controller;
  final double initialPosition;
  final double finalPosition;
  final double startPosition;
  final double endPosition;
  final Axis direction;
  final Widget? child;
}

// Implementation:--------------------------------------------------------------
class ShakeWidget extends AnimatedWidget implements ShakeWidgetInterface {
  ShakeWidget({
    super.key,
    required this.props,
  }) : super(listenable: props.controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  final ShakeWidgetProps props;

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(
              begin: props.initialPosition, end: props.endPosition),
          weight: 1),
      TweenSequenceItem(
          tween:
              Tween<double>(begin: props.endPosition, end: props.startPosition),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<double>(
              begin: props.startPosition, end: props.finalPosition),
          weight: 1),
    ]).animate(_progress);
    return Transform.translate(
      offset: Offset(props.direction == Axis.horizontal ? animation.value : 0,
          props.direction == Axis.vertical ? animation.value : 0),
      child: props.child ?? const SizedBox(),
    );
  }
}
