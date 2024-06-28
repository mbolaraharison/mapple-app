import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class TextInputWidgetInterface implements Widget {
  TextInputProps get props;
}

// Props:-----------------------------------------------------------------------
class TextInputProps {
  const TextInputProps({
    this.controller,
    this.height = 44,
    this.margin,
    this.autofocus = false,
    this.focusNode,
    this.label,
    this.labelWidth,
    this.hasError = false,
    this.placeholder,
    this.borderRadius,
    this.keyboardType,
    this.inputFormatters,
    this.style,
    this.maxLines = 1,
    this.suffix,
    this.disable = false,
    this.textAlign = TextAlign.start,
    this.withDebounce = false,
    this.debounceKey,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final double height;
  final EdgeInsetsGeometry? margin;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? label;
  final double? labelWidth;
  final bool hasError;
  final String? placeholder;
  final BorderRadius? borderRadius;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final int? maxLines;
  final Widget? suffix;
  final bool disable;
  final TextAlign textAlign;
  final bool withDebounce;
  final String? debounceKey;
  final Duration debounceDuration;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
}

// Implementation:--------------------------------------------------------------
class TextInput extends StatelessWidget implements TextInputWidgetInterface {
  TextInput({super.key, TextInputProps? props})
      : props = props ?? const TextInputProps();

  // Properties:----------------------------------------------------------------
  @override
  final TextInputProps props;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Static:--------------------------------------------------------------------
  static const defaultRadius = Radius.zero;

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      height: props.height,
      margin: props.margin,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: props.disable
            ? MapleCommonColors.disabledBackground
            : CupertinoColors.white,
        borderRadius:
            props.borderRadius ?? const BorderRadius.all(defaultRadius),
      ),
      child: CupertinoTextField(
        prefix: props.label != null
            ? SizedBox(
                width: props.labelWidth,
                child: Text(
                  props.label!,
                  style: TextStyle(
                    color: props.disable
                        ? CupertinoColors.inactiveGray
                        : (props.hasError
                            ? CupertinoColors.destructiveRed
                            : _appThemeData.defaultTextColor),
                  ),
                ),
              )
            : const SizedBox(),
        decoration: const BoxDecoration(color: CupertinoColors.white),
        controller: props.controller,
        focusNode: props.focusNode,
        placeholder: props.placeholder,
        autofocus: props.autofocus,
        padding: EdgeInsets.only(left: props.label != null ? 12 : 0),
        keyboardType: props.keyboardType,
        inputFormatters: props.inputFormatters,
        style: props.style ??
            TextStyle(
                color: props.disable
                    ? CupertinoColors.inactiveGray
                    : _appThemeData.defaultTextColor),
        maxLines: props.maxLines,
        suffix: props.suffix,
        enabled: !props.disable,
        textAlign: props.textAlign,
        onChanged: (value) {
          if (props.withDebounce && props.debounceKey != null) {
            EasyDebounce.debounce(
              props.debounceKey!,
              props.debounceDuration,
              () => props.onChanged?.call(value),
            );
            return;
          }

          props.onChanged?.call(value);
        },
        onSubmitted: props.onSubmitted,
      ),
    );
  }
}
