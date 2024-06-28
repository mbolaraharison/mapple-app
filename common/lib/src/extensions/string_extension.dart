import 'package:diacritic/diacritic.dart';

extension StringExtension on String {
  String toUnaccent() {
    return removeDiacritics(this);
  }

  String toSearchable() {
    return toLowerCase().toUnaccent();
  }

  String toCapitalized() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1);
  }

  String toCapitalizedWords() {
    return split(" ").map((word) => word.toCapitalized()).join(" ");
  }
}
