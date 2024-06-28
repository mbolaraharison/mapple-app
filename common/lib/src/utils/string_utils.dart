import 'dart:math';

// Interface:-------------------------------------------------------------------
abstract class StringUtilsInterface {
  String capitalize(String text);

  String? valueIfNotEmpty(String? text);

  String parse(dynamic value);

  bool isLetter(String text);

  String getInitialsFromName(String name);

  String generateString(int length);

  String generateStringWithMinAndMaxLength(int minLength, int maxLength);
}

// Implementation:--------------------------------------------------------------
class StringUtils implements StringUtilsInterface {
  StringUtils();

  @override
  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  String? valueIfNotEmpty(String? value) {
    if (value == null) {
      return null;
    }
    if (value.trim().isEmpty) {
      return null;
    }
    return value;
  }

  @override
  String parse(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  @override
  bool isLetter(String string) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(string);
  }

  @override
  String getInitialsFromName(String name) {
    final sanitizedName = name.trim();
    final words = sanitizedName.split(RegExp(r'\s+'));
    String initials = '';

    for (final word in words) {
      if (word.isNotEmpty) {
        final firstLetter = word.substring(0, 1);
        if (isLetter(firstLetter)) {
          initials += firstLetter;
        }
      }
      if (initials.length == 2) {
        break;
      }
    }

    return initials.toUpperCase();
  }

  @override
  String generateString(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  String generateStringWithMinAndMaxLength(int minLength, int maxLength) {
    final rnd = Random();
    final length = rnd.nextInt(maxLength - minLength + 1) + minLength;
    return generateString(length);
  }
}
