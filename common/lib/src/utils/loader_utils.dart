import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

// Interface:-------------------------------------------------------------------
abstract class LoaderUtilsInterface {
  void startLoading(BuildContext context);

  Future<void> stopLoading(BuildContext context);
}

// Implementations:-------------------------------------------------------------
class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class LoaderUtils implements LoaderUtilsInterface {
  AnimationController? _animationController;

  PageRoute? _route;

  @override
  void startLoading(BuildContext context) {
    _animationController ??= AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: TickerProviderImpl(),
    );

    _animationController!.forward();

    _route = PageRouteBuilder(
      settings: const RouteSettings(name: '/loader'),
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return FadeTransition(
          opacity: _animationController!,
          child: Container(
            color: CupertinoColors.black.withOpacity(0.4),
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );

    SchedulerBinding.instance.endOfFrame
        .then((_) => Navigator.of(context, rootNavigator: true).push(_route!));
  }

  @override
  Future<void> stopLoading(BuildContext context) async {
    _animationController?.reverse();
    await SchedulerBinding.instance.endOfFrame;
    _animationController = null;
    if (_route != null) {
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      Navigator.of(context, rootNavigator: true).removeRoute(_route!);
      _route = null;
    }
  }
}
