import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_painter/image_painter.dart';
import 'package:maple_common/maple_common.dart';
import 'package:flutter/material.dart' hide Image;

// Interface:-------------------------------------------------------------------
abstract class DrawingAreaDialogWidgetInterface implements Widget {
  DrawingAreaDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class DrawingAreaDialogProps {
  DrawingAreaDialogProps({
    required this.store,
    required this.width,
    required this.height,
  });

  final CustomerSiteSheetStoreInterface store;
  final double width;
  final double height;
}

// Implementation:--------------------------------------------------------------
class DrawingAreaDialog extends StatefulWidget
    implements DrawingAreaDialogWidgetInterface {
  const DrawingAreaDialog({super.key, required this.props});

  @override
  final DrawingAreaDialogProps props;

  @override
  State<DrawingAreaDialog> createState() => _DrawingAreaDialogState();
}

class _DrawingAreaDialogState extends State<DrawingAreaDialog> {
  // Dependencies:--------------------------------------------------------------
  late final ImageUtilsInterface _imageUtils = getIt<ImageUtilsInterface>();
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  final _imageKey = GlobalKey<ImagePainterState>();
  late final drawingAreaHeight = widget.props.height - 52;

  // Lifecycle methods:---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: widget.props.width,
        height: widget.props.height,
        physics: const ClampingScrollPhysics(),
        header: getIt<DialogHeaderWidgetInterface>(
          param1: DialogHeaderProps(
            leftContent: CupertinoButton(
              onPressed: () {
                _onClosePressed();
              },
              child: Text(
                'close'.tr(),
                style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
              ),
            ),
            middleContent: Text(
              'site_sheet.content.other.drawing_area'.tr(),
              style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
            ),
            rightContent: Observer(
              builder: (context) {
                if (widget.props.store.siteSheet!.drawingFileDataId == null) {
                  return const SizedBox();
                }

                return CupertinoButton(
                  onPressed: _onClearPressed,
                  child: Text(
                    'clear'.tr(),
                    style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
                  ),
                );
              },
            ),
          ),
        ),
        child: SizedBox(
          width: widget.props.width,
          height: drawingAreaHeight,
          child: Center(
            child: Observer(
              builder: (context) {
                if (widget.props.store.siteSheet!.drawingFileDataId != null) {
                  return FutureBuilder<File?>(
                    future: widget.props.store.siteSheet!.drawingFile,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CupertinoActivityIndicator();
                      }

                      final bytes = snapshot.data!.readAsBytesSync();
                      snapshot.data!.delete();

                      return Image.memory(bytes);
                    },
                  );
                }

                return FutureBuilder<Uint8List>(
                  future: _imageUtils.createGridImage(
                    SiteSheet.drawingAreaWidth,
                    SiteSheet.drawingAreaHeight,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CupertinoActivityIndicator();
                    }
                    return ClipRRect(
                      child: Material(
                        child: ImagePainter.memory(
                          snapshot.data!,
                          width: widget.props.width,
                          height: drawingAreaHeight,
                          scalable: true,
                          textDelegate: ImagePainterTextDelegate(),
                          initialColor: Colors.black,
                          key: _imageKey,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onClosePressed() async {
    // If read only or not edited, just close the dialog
    if (widget.props.store.siteSheet!.drawingFileDataId != null ||
        (_imageKey.currentState != null &&
            _imageKey.currentState!.isEdited == false)) {
      Navigator.pop(context);
      return;
    }

    // If edited, export the image and set it to the store
    _loaderUtils.startLoading(context);
    final image = await _imageKey.currentState?.exportImage();
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
    widget.props.store.setDrawing(image);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _onClearPressed() async {
    widget.props.store.clearDrawing();
  }
}
