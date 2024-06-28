import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class MainLayoutWidgetInterface implements Widget {
  MainLayoutProps get props;
}

// Props:-----------------------------------------------------------------------
class MainLayoutProps {
  MainLayoutProps({
    required this.child,
    this.headerTitle = '',
    this.headerRightChild,
    this.headerMode = HeaderMode.light,
    this.headerWithBackButton = false,
    this.headerWithSeparator = true,
    this.backgroundColor = CupertinoColors.white,
    this.disabledHeader = false,
    this.padding = const EdgeInsets.only(top: 17, left: 35, right: 35),
    this.headerPadding,
    this.onBackButtonTap,
  });

  final Widget child;
  final String headerTitle;
  final Widget? headerRightChild;
  final HeaderMode headerMode;
  final bool headerWithBackButton;
  final bool headerWithSeparator;
  final Color backgroundColor;
  final bool disabledHeader;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? headerPadding;
  final Function(BuildContext context)? onBackButtonTap;
}

// Implementation:--------------------------------------------------------------
class MainLayout extends StatelessWidget implements MainLayoutWidgetInterface {
  const MainLayout({
    super.key,
    required this.props,
  });

  @override
  final MainLayoutProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: props.padding,
      decoration: BoxDecoration(
        color: props.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!props.disabledHeader)
            getIt<HeaderWidgetInterface>(
              param1: HeaderProps(
                title: props.headerTitle,
                rightChild: props.headerRightChild,
                mode: props.headerMode,
                withBackButton: props.headerWithBackButton,
                withSeparator: props.headerWithSeparator,
                padding: props.headerPadding,
                onBackButtonTap: props.onBackButtonTap,
              ),
            ),
          Container(
            child: props.child,
          ),
        ],
      ),
    );
  }
}
