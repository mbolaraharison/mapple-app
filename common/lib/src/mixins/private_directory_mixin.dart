import 'dart:io';

import 'package:path_provider/path_provider.dart';

mixin PrivateDirectoryMixin {
  Future<Directory> get privateDirectory async {
    return getPrivateDirectory();
  }

  static Future<Directory> getPrivateDirectory() async {
    final libraryDirectory = await getLibraryDirectory();
    final path = '${libraryDirectory.path}/Private';
    // Create directory if not exists
    final directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync();
    }
    return directory;
  }
}
