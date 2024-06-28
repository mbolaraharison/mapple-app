import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class DropDownMenuWidgetInterface implements Widget {
  DropDownMenuProps get props;
}

// Props:-----------------------------------------------------------------------
class DropDownMenuProps {
  const DropDownMenuProps({
    this.label,
    this.child,
  });

  final String? label;
  final Widget? child;
}

// Implementation:--------------------------------------------------------------
class DropDownMenu extends StatefulWidget
    implements DropDownMenuWidgetInterface {
  const DropDownMenu({
    super.key,
    DropDownMenuProps? props,
  }) : props = props ?? const DropDownMenuProps();

  @override
  final DropDownMenuProps props;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  // States:--------------------------------------------------------------------
  bool open = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.props.label ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            CupertinoButton(
              onPressed: () => setState(() {
                open = !open;
              }),
              padding: EdgeInsets.zero,
              child: Icon(
                open == true
                    ? CupertinoIcons.chevron_down
                    : CupertinoIcons.chevron_up,
                color: CupertinoColors.destructiveRed,
                size: 26,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        open == true && widget.props.child != null
            ? widget.props.child!
            : const SizedBox(),
      ],
    );
  }
}
