import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:sanitize_filename/sanitize_filename.dart';

// Interface:-------------------------------------------------------------------
abstract class FileUtilsInterface {
  String formatSize(double size);

  Future<File> save({required String path, File? file});

  Future<String> getUploadPath({
    required String agencyName,
    required String customerName,
    required String fileName,
  });
}

// Implementation:--------------------------------------------------------------
class FileUtils implements FileUtilsInterface {
  @override
  String formatSize(double size) {
    if (size < 1024) {
      return '${size.toStringAsFixed(2)}o';
    }
    if (size < pow(1024, 2)) {
      return '${(size / 1024).toStringAsFixed(2)}Ko';
    }
    if (size < pow(1024, 3)) {
      return '${(size / pow(1024, 2)).toStringAsFixed(2)}Mo';
    }
    if (size < pow(1024, 4)) {
      return '${(size / pow(1024, 3)).toStringAsFixed(2)}Go';
    }
    return '${(size / pow(1024, 4)).toStringAsFixed(2)}To';
  }

  @override
  Future<File> save({required String path, File? file}) async {
    // Create directories if not exists
    final List<String> directories = path.split('/');
    // Last element is the file name
    directories.removeLast();

    final String dirPath = directories.join('/');
    final Directory dir = Directory(dirPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // Save file
    if (file != null) {
      return file.copy(path);
    }

    return File(path);
  }

  @override
  Future<String> getUploadPath({
    required String agencyName,
    required String customerName,
    required String fileName,
  }) async {
    final Directory uploadDir = await getApplicationDocumentsDirectory();
    final String sanitizedAgencyName = sanitizeFilename(agencyName);
    final String sanitizedCustomerName = sanitizeFilename(customerName);

    return '${uploadDir.path}/$sanitizedAgencyName/$sanitizedCustomerName/$fileName';
  }
}
