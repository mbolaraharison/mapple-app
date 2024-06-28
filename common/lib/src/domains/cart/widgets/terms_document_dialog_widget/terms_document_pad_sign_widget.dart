import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

// Interface:-------------------------------------------------------------------
abstract class TermsDocumentPadSignWidgetInterface implements Widget {
  TermsDocumentPadSignProps get props;
}

// Props:-----------------------------------------------------------------------
class TermsDocumentPadSignProps {
  TermsDocumentPadSignProps({
    required this.termsDialogStore,
    required this.customerOrderStore,
  });

  final TermsDialogStoreInterface termsDialogStore;
  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class TermsDocumentPadSign extends StatefulWidget
    implements TermsDocumentPadSignWidgetInterface {
  const TermsDocumentPadSign({super.key, required this.props});

  @override
  final TermsDocumentPadSignProps props;

  @override
  State<TermsDocumentPadSign> createState() => _TermsDocumentPadSignState();
}

class _TermsDocumentPadSignState extends State<TermsDocumentPadSign> {
  // Stores:--------------------------------------------------------------------
  final _sign = GlobalKey<SignatureState>();
  final StringUtilsInterface _stringUtils = getIt<StringUtilsInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        header: _buildHeader(context),
        child: _buildContent(context),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: Row(
          children: [
            CupertinoButton(
              child: Text(
                'cancel'.tr(),
                style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        middleContent: Text(
          'cart.terms_document'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: widget.props.termsDialogStore.hasSignature
                      ? () {
                          final sign = _sign.currentState;
                          sign!.clear();
                          widget.props.termsDialogStore.setHasSignature(false);
                          widget.props.termsDialogStore.setImage(null);
                        }
                      : null,
                  child: Text(
                    'clear'.tr(),
                    style: widget.props.termsDialogStore.hasSignature
                        ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        : const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ),
                CupertinoButton(
                  onPressed:
                      widget.props.termsDialogStore.hasBeenSubmitted == false &&
                              widget.props.termsDialogStore.hasSignature
                          ? () => _onSubmit(context)
                          : null,
                  child: Text(
                    'ok'.tr().toUpperCase(),
                    style: widget.props.termsDialogStore.hasSignature
                        ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                            .copyWith(fontWeight: FontWeight.w600)
                        : const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Signature(
        color: Colors.black,
        key: _sign,
        onSign: () {
          widget.props.termsDialogStore.setHasSignature(true);
        },
        backgroundPainter: null,
        strokeWidth: 5.0,
      ),
    );
  }

  Future<void> _onSubmit(BuildContext contex) async {
    widget.props.termsDialogStore.setHasBeenSubmitted(true);
    final sign = _sign.currentState;
    final image = await sign!.getData();
    // convert image to base64 encoded string
    final imageBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    // write to file
    Directory directory = await getTemporaryDirectory();
    String filename = _stringUtils.generateString(10);
    final file = File('${directory.path}/$filename.png');
    await file.writeAsBytes(imageBytes!.buffer.asUint8List());
    await Future.delayed(const Duration(milliseconds: 500));
    widget.props.termsDialogStore.setImage(file);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    widget.props.termsDialogStore.setHasBeenSubmitted(false);
  }
}
