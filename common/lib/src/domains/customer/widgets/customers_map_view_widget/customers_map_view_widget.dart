import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart'
    hide Cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomersMapViewWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CustomersMapView extends StatefulWidget
    implements CustomersMapViewWidgetInterface {
  const CustomersMapView({super.key});

  @override
  State<CustomersMapView> createState() => _CustomersMapViewState();
}

class _CustomersMapViewState extends State<CustomersMapView> {
  static const Color markerColorPrimary = Color(0xFFEA4334);
  static const Color markerColorSecondary = Color(0xFFB21611);
  // Stores:--------------------------------------------------------------------
  late final CustomersMapViewStoreInterface _store =
      getIt<CustomersMapViewStoreInterface>();
  late final LocationStoreInterface _locationStore =
      getIt<LocationStoreInterface>();
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();

  // Variables:-----------------------------------------------------------------
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  late ClusterManager _manager;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _locationStore.getCurrentLocation();
    _initClusterManager();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (!_locationStore.locationIsEnabled ||
          _locationStore.currentLocation == null) {
        return Center(child: Text('customer_list.location_disabled'.tr()));
      }

      if (!_store.isMapReady) {
        return const Center(child: CupertinoActivityIndicator());
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              _locationStore.currentLocation!.latitude!,
              _locationStore.currentLocation!.longitude!,
            ),
            zoom: 16,
          ),
          myLocationEnabled: true,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _manager.setMapId(controller.mapId);
          },
          onCameraMove: _manager.onCameraMove,
          onCameraIdle: _manager.updateMap,
        ),
      );
    });
  }

  // General methods:-----------------------------------------------------------
  Future<void> _initClusterManager() async {
    final List<Order> orders = [];
    List<Order> orders0 = await _orderService.getAll();
    for (final order in orders0) {
      GeoPoint? location = order.location;
      if (order.location == null && order.locationAlreadyFetched == false) {
        location = await _orderService.getLocation(order);
      }

      if (location == null) {
        continue;
      }

      if (orders.firstWhereOrNull((element2) =>
              element2.location == location &&
              element2.customerId == order.customerId) !=
          null) {
        continue;
      }

      // Skip if order should not be displayed
      if (!order.status.displayedOnMap) {
        continue;
      }

      await order.loadCustomer();
      orders.add(order);
    }
    final List<Place> items = orders.map((e) => Place(order: e)).toList();
    _manager = ClusterManager<Place>(
      items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      levels: [
        1,
        4.25,
        6.75,
        8.25,
        11.5,
        13,
        14.5,
        15.25,
        16.0,
        16.5,
        20.0,
      ],
    );

    _store.setMapReady();
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  Future<Marker> Function(dynamic) get _markerBuilder => (cluster) async {
        if (cluster.isMultiple) {
          return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            icon: await _getMarkerBitmap(cluster.count.toString()),
          );
        }

        final Order order = cluster.items.first.order;

        BitmapDescriptor markerIcon;
        switch (order.status) {
          case OrderStatus.B:
            markerIcon =
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
            break;
          case OrderStatus.E:
            markerIcon = BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen);
            break;
          case OrderStatus.Z:
            markerIcon =
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
            break;
          default:
            markerIcon = BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange);
        }

        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: order.customer!.formattedName,
            snippet: '${order.formattedAddress}\n${order.status.label}',
          ),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(String text) async {
    const size = 100;
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = markerColorPrimary;
    final Paint paint2 = Paint()..color = markerColorSecondary;
    final Paint paint3 = Paint()..color = CupertinoColors.white;

    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.0, paint3);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.1, paint1);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 3.5, paint2);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: size / 2.5,
        color: CupertinoColors.white,
        fontWeight: FontWeight.normal,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
