import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:geocoding/geocoding.dart';

// Interface:-------------------------------------------------------------------
abstract class StreetViewWidgetInterface implements Widget {
  StreetViewProps get props;
}

// Props:-----------------------------------------------------------------------
class StreetViewProps {
  const StreetViewProps({
    required this.address,
  });

  final String address;
}

// Implementation:--------------------------------------------------------------
class StreetView extends StatefulWidget implements StreetViewWidgetInterface {
  const StreetView({super.key, required this.props});

  @override
  final StreetViewProps props;

  @override
  State<StreetView> createState() => _StreetViewState();
}

class _StreetViewState extends State<StreetView> {
  double latitude = 0;
  double longitude = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    List locations = await locationFromAddress(widget.props.address);
    if (locations.isNotEmpty) {
      setState(() {
        latitude = locations[0].latitude;
        longitude = locations[0].longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterGoogleStreetView(
      initPos: LatLng(latitude, longitude),
      initSource: StreetViewSource.outdoor,
      initBearing: 0,
      zoomGesturesEnabled: true,
      enableCloseButton: true,
      panControl: true,
    );
  }
}
