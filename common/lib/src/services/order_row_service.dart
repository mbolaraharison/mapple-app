import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class OrderRowServiceInterface {
  Future<List<OrderRow>> getByOrderId(String orderId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<OrderRow>> getByOrderIdAsStream(String orderId,
      {bool eager = false, List<Type> flow = const []});

  Future<void> create(OrderRow item, {bool applyToFirestore = true});

  Future<void> update(OrderRow item, {bool applyToFirestore = true});

  Future<void> delete(OrderRow item, {bool applyToFirestore = true});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class OrderRowService
    extends AbstractModelService<OrderRow, $OrderRowsTable, AgencyDatabase>
    implements OrderRowServiceInterface {
  OrderRowService()
      : super(getIt<OrderRowDriftDao>(), getIt<OrderRowFirestoreDao>());
  // Methods:-------------------------------------------------------------------
  @override
  Future<List<OrderRow>> getByOrderId(String orderId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<OrderRow> orderRows =
        await (localDao as OrderRowDriftDao).findByOrderId(orderId);
    if (eager) {
      for (int i = 0; i < orderRows.length; i++) {
        await orderRows[i].loadData(eager: eager, flow: flow);
      }
    }
    return orderRows;
  }

  @override
  Stream<List<OrderRow>> getByOrderIdAsStream(String orderId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<OrderRow>> orderRowsStream = (localDao as OrderRowDriftDao)
        .findByOrderIdAsStream(orderId)
        .transform(streamTransformerUtils
            .getListResultDriftStreamOptimizer<OrderRow>());
    if (eager) {
      orderRowsStream =
          orderRowsStream.asyncMap((List<OrderRow> orderRows) async {
        for (int i = 0; i < orderRows.length; i++) {
          await orderRows[i].loadData(eager: eager, flow: flow);
        }
        return orderRows;
      });
    }
    return orderRowsStream;
  }
}
