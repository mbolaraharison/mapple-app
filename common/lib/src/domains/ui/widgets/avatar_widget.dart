import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AvatarWidgetInterface implements Widget {
  AvatarProps get props;
}

// Props:-----------------------------------------------------------------------
class AvatarProps {
  AvatarProps({
    required this.firstLetter,
    this.secondLetter,
    this.size = 56,
    this.fontSize = 25,
    color,
    this.lettersColor = Colors.white,
  }) : color = color ?? getIt<AppThemeDataInterface>().avatarDefaultBgColor;

  final String firstLetter;

  final String? secondLetter;

  final double size;

  final double fontSize;

  final Color? color;

  final Color lettersColor;
}

// Implementation:--------------------------------------------------------------
class Avatar extends StatelessWidget implements AvatarWidgetInterface {
  const Avatar({
    super.key,
    required this.props,
  });

  @override
  final AvatarProps props;

  @override
  Widget build(BuildContext context) {
    final String firstLetterSanitized = props.firstLetter.length > 1
        ? props.firstLetter.substring(0, 1).toUpperCase()
        : props.firstLetter.toUpperCase();

    final String secondLetterSanitized = props.secondLetter != null
        ? props.secondLetter!.length > 1
            ? props.secondLetter!.substring(0, 1).toUpperCase()
            : props.secondLetter!.toUpperCase()
        : '';

    final avaterText = '$firstLetterSanitized$secondLetterSanitized';

    return Container(
      height: props.size,
      width: props.size,
      decoration: BoxDecoration(
        color: props.color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          avaterText,
          style: TextStyle(
            color: props.lettersColor,
            fontSize: props.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
