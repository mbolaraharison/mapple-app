import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class DialogContentWrapperWidgetInterface implements Widget {
  DialogContentWrapperProps get props;
}

// Props:-----------------------------------------------------------------------
class DialogContentWrapperProps {
  const DialogContentWrapperProps({
    this.color = CupertinoColors.secondarySystemBackground,
    this.header,
    this.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    required this.child,
  });

  final Color color;
  final Widget? header;
  final ScrollPhysics physics;
  final Widget child;
}

// Implementation:--------------------------------------------------------------
class DialogContentWrapper extends StatelessWidget
    implements DialogContentWrapperWidgetInterface {
  const DialogContentWrapper({super.key, required this.props});

  @override
  final DialogContentWrapperProps props;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (props.header != null) {
      children.add(props.header!);
    }

    children.add(
      Expanded(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: CupertinoScrollbar(
            child: SingleChildScrollView(
              physics: props.physics,
              child: props.child,
            ),
          ),
        ),
      ),
    );

    return Container(
      color: props.color,
      child: Column(children: children),
    );
  }
}
