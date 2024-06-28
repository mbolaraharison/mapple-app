import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RowButtonWidgetInterface implements Widget {
  RowButtonProps get props;
}

// Props:-----------------------------------------------------------------------
class RowButtonProps {
  const RowButtonProps({
    this.height = 44,
    this.width = double.infinity,
    this.child,
    this.margin,
    this.rightChild,
    this.disableRightChild = false,
    this.borderRadius,
    this.onPressed,
    this.onPressedWhenDisabled,
    this.value,
    this.valueColor = CupertinoColors.inactiveGray,
    this.disable = false,
    this.disableOnTapEffect = false,
  });

  final double height;
  final double width;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Widget? rightChild;
  final bool disableRightChild;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedWhenDisabled;
  final String? value;
  final Color? valueColor;
  final bool disable;
  final bool disableOnTapEffect;
}

// Implementation:--------------------------------------------------------------
class RowButton extends StatefulWidget implements RowButtonWidgetInterface {
  const RowButton({
    super.key,
    RowButtonProps? props,
  }) : props = props ?? const RowButtonProps();

  @override
  final RowButtonProps props;

  @override
  State<RowButton> createState() => _RowButtonState();
}

class _RowButtonState extends State<RowButton> {
  // Stores:--------------------------------------------------------------------
  final _store = RowButtonStore();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (widget.props.child != null) {
      if (widget.props.value != null) {
        children.add(
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: widget.props.child!),
        );
        children.add(
          Expanded(
            flex: 3,
            child: Text(
              widget.props.value!,
              style: TextStyle(
                fontSize: 17,
                color: widget.props.valueColor,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.right,
            ),
          ),
        );
      } else {
        children.add(
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.props.child!),
          ),
        );
      }
    } else {
      if (widget.props.value != null) {
        children.add(
          Expanded(
            flex: 3,
            child: Text(
              widget.props.value!,
              style: TextStyle(
                fontSize: 17,
                color: widget.props.valueColor,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        );
      }
    }

    if (!widget.props.disableRightChild) {
      children.add(
        widget.props.rightChild ??
            Icon(
              CupertinoIcons.chevron_forward,
              color: MapleCommonColors.greyLight.withOpacity(.53),
              size: 21.0,
            ),
      );
    }

    return GestureDetector(
      onTap: _onTap,
      onTapDown: !widget.props.disableOnTapEffect
          ? (_) => _store.setTapped(true)
          : null,
      onTapUp: !widget.props.disableOnTapEffect
          ? (_) => _store.setTapped(false)
          : null,
      onTapCancel: !widget.props.disableOnTapEffect
          ? () => _store.setTapped(false)
          : null,
      child: Observer(
        builder: (context) => Container(
          height: widget.props.height,
          width: widget.props.width,
          constraints: BoxConstraints(
            minHeight: widget.props.height,
          ),
          margin: widget.props.margin,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: widget.props.borderRadius ?? BorderRadius.zero,
              color: _store.isTapped || widget.props.disable
                  ? MapleCommonColors.disabledBackground
                  : CupertinoColors.white),
          child: Row(
            children: children,
          ),
        ),
      ),
    );
  }

  Future<void> _onTap() async {
    if (!widget.props.disable) {
      widget.props.onPressed?.call();
      if (!widget.props.disableOnTapEffect) {
        _store.setTapped(true);
        Timer(const Duration(milliseconds: 100), () => _store.setTapped(false));
      }
      return;
    } else {
      if (widget.props.onPressedWhenDisabled != null) {
        widget.props.onPressedWhenDisabled?.call();
        if (!widget.props.disableOnTapEffect) {
          _store.setTapped(true);
          Timer(
              const Duration(milliseconds: 100), () => _store.setTapped(false));
        }
        return;
      }
    }
  }
}
