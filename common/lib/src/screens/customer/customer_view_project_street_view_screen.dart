import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerViewProjectStreetViewScreenInterface implements Widget {
  CustomerViewProjectStreetViewScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class CustomerViewProjectStreetViewScreen extends StatefulWidget
    implements CustomerViewProjectStreetViewScreenInterface {
  // Constructor:---------------------------------------------------------------
  const CustomerViewProjectStreetViewScreen(
      {super.key, required this.arguments});

  @override
  final CustomerViewProjectStreetViewScreenArguments arguments;

  @override
  State<CustomerViewProjectStreetViewScreen> createState() =>
      _CustomerViewProjectStreetViewScreenState();
}

class _CustomerViewProjectStreetViewScreenState
    extends State<CustomerViewProjectStreetViewScreen> {
  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        backgroundColor: Colors.transparent,
        disabledHeader: true,
        padding: EdgeInsets.zero,
        child: Expanded(
          child: Stack(
            children: [
              getIt<StreetViewWidgetInterface>(
                param1: StreetViewProps(
                  address: widget.arguments.projectAddress,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, top: 24),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    MapleCommonAssets.backCircle,
                    height: 33,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
