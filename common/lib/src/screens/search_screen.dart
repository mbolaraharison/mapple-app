import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class SearchScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class SearchScreen extends StatefulWidget implements SearchScreenInterface {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        headerTitle: 'search_title'.tr(),
        child: const Center(child: Text('test')),
      ),
    );
  }
}
