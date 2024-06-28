import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectCustomerSignatoriesWidgetInterface implements Widget {
  SelectCustomerSignatoriesProps get props;
}

// Props:-----------------------------------------------------------------------
class SelectCustomerSignatoriesProps {
  const SelectCustomerSignatoriesProps({
    required this.customerOrderStore,
    required this.list,
    this.avatarBgColor,
    this.addButtonColor,
    this.avatarInitialsColor,
    this.avatarNameColor,
    this.padding,
    this.onAvatarPressed,
    required this.onEditPressed,
  });

  final CustomerOrderStoreInterface customerOrderStore;
  final List<SelectForSignatureBaseModel> list;
  final Color? avatarBgColor;
  final Color? addButtonColor;
  final Color? avatarInitialsColor;
  final Color? avatarNameColor;
  final EdgeInsets? padding;
  final void Function() onEditPressed;
  final void Function(SelectForSignatureBaseModel model)? onAvatarPressed;
}

// Theme:-----------------------------------------------------------------------
abstract class SelectCustomerSignatoriesThemeInterface {
  Color get avatarlettersColor;
}

// Implementation:--------------------------------------------------------------
class SelectCustomerSignatories extends StatefulWidget
    implements SelectCustomerSignatoriesWidgetInterface {
  const SelectCustomerSignatories({super.key, required this.props});

  @override
  final SelectCustomerSignatoriesProps props;

  @override
  State<SelectCustomerSignatories> createState() =>
      _SelectCustomerSignatoriesState();
}

class _SelectCustomerSignatoriesState extends State<SelectCustomerSignatories> {
  // Themes:--------------------------------------------------------------------
  final SelectCustomerSignatoriesThemeInterface _theme =
      getIt<SelectCustomerSignatoriesThemeInterface>();

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        List<Widget> avatarsList = _buildSignatoryAvatarsList(
            widget.props.list, widget.props.onAvatarPressed);
        if (!widget.props.customerOrderStore.order.isReadonly) {
          avatarsList.add(
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: CupertinoButton(
                onPressed: widget.props.onEditPressed,
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.pencil_circle,
                  color: widget.props.addButtonColor ?? Colors.white,
                  size: 40,
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: widget.props.padding ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: avatarsList,
          ),
        );
      },
    );
  }

  List<Widget> _buildSignatoryAvatarsList(
      List<SelectForSignatureBaseModel> list,
      void Function(SelectForSignatureBaseModel model)? onTap) {
    List<Widget> avatarsList = [];
    for (int i = 0; i < list.length; i++) {
      String firstLetter = (list[i].initials).substring(0, 1);
      String secondLetter = '';
      if ((list[i].initials).length >= 2) {
        secondLetter = (list[i].initials).substring(1, 2);
      }
      avatarsList.add(
        Padding(
          padding: EdgeInsets.only(left: i != 0 ? 20 : 0),
          child: GestureDetector(
            onTap: !widget.props.customerOrderStore.order.isReadonly
                ? () => onTap != null ? onTap(list[i]) : null
                : null,
            child: Column(
              children: [
                getIt<AvatarWidgetInterface>(
                  param1: AvatarProps(
                    firstLetter: firstLetter,
                    secondLetter: secondLetter,
                    color: widget.props.customerOrderStore.order.isReadonly
                        ? MapleCommonColors.disabledBackground
                        : (widget.props.avatarBgColor ?? Colors.white),
                    lettersColor: widget.props.avatarInitialsColor ??
                        _theme.avatarlettersColor,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 62,
                  child: Text(
                    list[i].shortFullName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.props.avatarNameColor ?? Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return avatarsList;
  }
}
