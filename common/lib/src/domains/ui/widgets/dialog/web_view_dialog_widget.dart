import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Interface:-------------------------------------------------------------------
abstract class WebViewDialogWidgetInterface implements Widget {
  WebViewDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class WebViewDialogProps {
  WebViewDialogProps({
    required this.initialUrl,
    this.onWebViewCreated,
    this.onWebViewClosed,
    this.onUrlChange,
    this.onLoadError,
  });

  final String initialUrl;
  final void Function(InAppWebViewController)? onWebViewCreated;
  final void Function()? onWebViewClosed;
  final void Function(InAppWebViewController, Uri?)? onUrlChange;
  final void Function(InAppWebViewController, Uri?, int, String)? onLoadError;
}

// Implementation:--------------------------------------------------------------
class WebViewDialog extends StatefulWidget
    implements WebViewDialogWidgetInterface {
  const WebViewDialog({super.key, required this.props});

  @override
  final WebViewDialogProps props;

  @override
  State<WebViewDialog> createState() => _WebViewDialogState();
}

class _WebViewDialogState extends State<WebViewDialog> {
  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Others:--------------------------------------------------------------------
  final UniqueKey _webViewKey = UniqueKey();
  final Set<Factory<VerticalDragGestureRecognizer>> gestureRecognizers = {
    Factory(() => VerticalDragGestureRecognizer())
  };

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        disableContentWrapper: false,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        header: _buildHeader(),
        borderRadius: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 50,
          child: InAppWebView(
            key: _webViewKey,
            initialUrlRequest:
                URLRequest(url: Uri.parse(widget.props.initialUrl)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
              ),
            ),
            onLoadStart: widget.props.onUrlChange,
            onWebViewCreated: widget.props.onWebViewCreated,
            onLoadError: widget.props.onLoadError,
            gestureRecognizers: gestureRecognizers,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: widget.props.onWebViewClosed ??
              () => _rootNavigator.key.currentState?.pop(),
          child: Text('close'.tr(),
              style: DialogHeaderWidgetInterface.sideDefaultTextStyle),
        ),
        middleContent: Text(
          'signature_label'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }
}
