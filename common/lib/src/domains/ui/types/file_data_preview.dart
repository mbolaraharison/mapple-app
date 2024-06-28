import 'package:maple_common/maple_common.dart';

class FileDataPreview {
  FileDataPreview(
      {required this.fileData,
      required this.isImage,
      required this.directoryPath});
  FileData fileData;
  bool? isImage;
  String directoryPath = '';
}
