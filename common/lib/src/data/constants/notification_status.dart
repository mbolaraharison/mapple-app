// ignore_for_file: constant_identifier_names

enum NotificationStatus {
  NOT_READY,
  READY,
  SENT,
  FAILED;

  static NotificationStatus fromValue(String? value) {
    if (value == null) {
      return NOT_READY;
    }
    return NotificationStatus.values.firstWhere(
        (element) => element.name == value,
        orElse: () => NOT_READY);
  }
}
