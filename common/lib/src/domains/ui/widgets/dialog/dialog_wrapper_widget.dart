import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DialogWrapperWidgetInterface implements Widget {
  DialogWrapperProps get props;
}

// Props:-----------------------------------------------------------------------
class DialogWrapperProps {
  const DialogWrapperProps({
    required this.width,
    required this.height,
    required this.child,
    this.header,
    this.disableContentWrapper = false,
    this.color = CupertinoColors.secondarySystemBackground,
    this.borderRadius = 12,
    this.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
  });

  final double width;
  final double height;
  final Widget? header;
  final Widget child;
  final bool disableContentWrapper;
  final Color? color;
  final double borderRadius;
  final ScrollPhysics physics;
}

// Implementation:--------------------------------------------------------------
class DialogWrapper extends StatelessWidget
    implements DialogWrapperWidgetInterface {
  const DialogWrapper({super.key, required this.props});

  @override
  final DialogWrapperProps props;

  @override
  Widget build(BuildContext context) {
    double spaceBottom =
        (MediaQuery.of(context).size.height - props.height) / 2;
    double paddingBottom =
        MediaQuery.of(context).viewInsets.bottom - spaceBottom;

    return Center(
      child: Container(
        width: props.width,
        height: props.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: props.color,
          borderRadius: BorderRadius.all(
            Radius.circular(props.borderRadius),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: paddingBottom > 0 ? paddingBottom : 0),
          child: props.disableContentWrapper
              ? props.child
              : getIt<DialogContentWrapperWidgetInterface>(
                  param1: DialogContentWrapperProps(
                    header: props.header,
                    physics: props.physics,
                    child: props.child,
                  ),
                ),
        ),
      ),
    );
  }
}
