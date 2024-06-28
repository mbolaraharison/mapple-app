import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maple_common/maple_common.dart';

class Place with ClusterItem {
  final Order order;

  Place({required this.order});

  @override
  LatLng get location =>
      LatLng(order.location!.latitude, order.location!.longitude);
}
