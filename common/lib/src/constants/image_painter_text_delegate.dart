import 'package:easy_localization/easy_localization.dart';
import 'package:image_painter/image_painter.dart';

class ImagePainterTextDelegate implements TextDelegate {
  @override
  String get arrow => 'image_painter.arrow'.tr();

  @override
  String get changeBrushSize => 'image_painter.change_brush_size'.tr();

  @override
  String get changeColor => 'image_painter.change_color'.tr();

  @override
  String get changeMode => 'image_painter.change_mode'.tr();

  @override
  String get circle => 'image_painter.circle'.tr();

  @override
  String get clearAllProgress => 'image_painter.clear_all_progress'.tr();

  @override
  String get dashLine => 'image_painter.dash_line'.tr();

  @override
  String get done => 'image_painter.done'.tr();

  @override
  String get drawing => 'image_painter.drawing'.tr();

  @override
  String get line => 'image_painter.line'.tr();

  @override
  String get noneZoom => 'image_painter.none_zoom'.tr();

  @override
  String get rectangle => 'image_painter.rectangle'.tr();

  @override
  String get text => 'image_painter.text'.tr();

  @override
  String get undo => 'image_painter.undo'.tr();
}
