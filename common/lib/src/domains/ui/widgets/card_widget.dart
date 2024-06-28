import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class CardWidgetInterface implements Widget {
  CardProps get props;
}

// Props:-----------------------------------------------------------------------
class CardProps {
  const CardProps({
    this.width = double.infinity,
    this.height = double.infinity,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;
}

// Implementation:--------------------------------------------------------------
class Card extends StatelessWidget implements CardWidgetInterface {
  const Card({
    super.key,
    required this.props,
  });

  @override
  final CardProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: props.width,
      height: props.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 40,
                color: CupertinoColors.black.withOpacity(.2))
          ],
          color: CupertinoColors.white),
      child: props.child,
    );
  }
}
