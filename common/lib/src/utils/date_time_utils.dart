import 'package:intl/intl.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DateTimeUtilsInterface {
  String formatToHumanReadable(DateTime dateTime);

  String formatToFrenchDate(DateTime dateTime);

  String format(DateTime dateTime, String format);

  String formatWithCurrentDateDetection(DateTime dateTime);
}

// Implementation:--------------------------------------------------------------
class DateTimeUtils implements DateTimeUtilsInterface {
  @override
  String formatToHumanReadable(DateTime dateTime) {
    final StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return stringUtils.capitalize(
        "${DateFormat.MMMMd().format(dateTime)} ${DateFormat.Hm().format(dateTime)}");
  }

  @override
  String formatToFrenchDate(DateTime dateTime) {
    return format(dateTime, 'dd/MM/yyyy');
  }

  @override
  String format(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  @override
  String formatWithCurrentDateDetection(DateTime dateTime) {
    DateTime currentDateTime = DateTime.now();
    String formattedCurrentDate = format(currentDateTime, 'dd/MM/yyyy');
    String formattedDateTime = format(dateTime, 'dd/MM/yyyy');
    if (formattedCurrentDate == formattedDateTime) {
      return 'aujourd\'hui ${format(dateTime, 'HH:mm')}';
    } else {
      return format(dateTime, 'dd/MM/yyyy HH:mm');
    }
  }
}
