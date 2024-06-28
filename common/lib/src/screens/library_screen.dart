import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class LibraryScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class LibraryScreen extends StatefulWidget implements LibraryScreenInterface {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        headerTitle: 'library_title'.tr(),
        child: const Center(child: Text('test')),
      ),
    );
  }
}
