import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Interface:-------------------------------------------------------------------
abstract class TextInputWithLabelWidgetInterface implements Widget {
  TextInputWithLabelProps get props;
}

// Props:-----------------------------------------------------------------------
class TextInputWithLabelProps {
  const TextInputWithLabelProps({
    required this.label,
    this.controller,
    this.onChanged,
    this.placeholder,
    this.labelStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.width = double.infinity,
    this.height = 47,
    this.readOnly = false,
    this.labelWidth = 150,
    this.inputValueWidth = 300,
    this.textAlign = TextAlign.start,
    this.textStyle = const TextStyle(),
    this.decoration = const BoxDecoration(
      color: Colors.white,
    ),
    this.inputFormatters,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? placeholder;
  final double width;
  final double height;
  final String label;
  final TextStyle? labelStyle;
  final double labelWidth;
  final double inputValueWidth;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final bool obscureText;
  final BoxDecoration decoration;
  final List<TextInputFormatter>? inputFormatters;
}

// Implementation:--------------------------------------------------------------
class TextInputWithLabel extends StatelessWidget
    implements TextInputWithLabelWidgetInterface {
  const TextInputWithLabel({super.key, required this.props});

  @override
  final TextInputWithLabelProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: props.height,
      width: props.width,
      decoration: props.decoration,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            SizedBox(
              width: props.labelWidth,
              child: Text(
                props.label,
                style: props.labelStyle,
              ),
            ),
            SizedBox(
              width: props.inputValueWidth,
              child: CupertinoTextField(
                textAlign: props.textAlign,
                keyboardType: props.keyboardType,
                inputFormatters: props.inputFormatters,
                obscureText: props.obscureText,
                readOnly: props.readOnly,
                decoration: const BoxDecoration(border: null),
                style: props.textStyle,
                controller: props.controller,
                placeholder: props.placeholder,
                onChanged: props.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
