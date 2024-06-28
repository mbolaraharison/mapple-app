import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart' as img;

// Interface:-------------------------------------------------------------------
abstract class ImageUtilsInterface {
  Uint8List rotateImage(Uint8List imageData);
  Future<Uint8List> createGridImage(double width, double height,
      {double gridCellSize = 50});
}

// Implementation:--------------------------------------------------------------
class ImageUtils implements ImageUtilsInterface {
  @override
  Uint8List rotateImage(Uint8List imageData) {
    // Convert Uint8List to Image
    img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      throw Exception('Unable decode the image');
    }

    // Rotate the image 90 degrees clockwise
    img.Image rotatedImage = img.copyRotate(image, angle: 90);

    // Convert the rotated image back to Uint8List
    Uint8List rotatedImageData =
        Uint8List.fromList(img.encodePng(rotatedImage));

    return rotatedImageData;
  }

  @override
  Future<Uint8List> createGridImage(double width, double height,
      {double gridCellSize = 50}) async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint()..color = Colors.white;
    final Rect rect = Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());

    canvas.drawRect(rect, paint);

    final Paint gridPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    for (double i = gridCellSize; i < width; i += gridCellSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, height), gridPaint);
    }
    for (double i = gridCellSize; i < height; i += gridCellSize) {
      canvas.drawLine(Offset(0, i), Offset(width, i), gridPaint);
    }

    final Picture picture = recorder.endRecording();
    final Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData? byteData =
        await image.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}
