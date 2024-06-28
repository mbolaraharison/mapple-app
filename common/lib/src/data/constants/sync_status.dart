// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum SyncStatus {
  NOT_READY('sync_status.not_ready'),
  READY_FOR_CREATE('sync_status.ready_for_create'),
  QUEUED_FOR_CREATE('sync_status.queued_for_create'),
  CREATE_FAILED('sync_status.create_failed'),
  READY_FOR_UPDATE('sync_status.ready_for_update'),
  QUEUED_FOR_UPDATE('sync_status.queued_for_update'),
  LOCKED('sync_status.locked'),
  UPDATE_FAILED('sync_status.update_failed'),
  OK('sync_status.ok'),
  SYNCING('sync_status.syncing'),
  CUSTOMER_NOT_OK('sync_status.customer_not_ok'),
  ORDER_NOT_OK('sync_status.order_not_ok');

  const SyncStatus(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();
}
