import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServicesSearchWidgetInterface implements Widget {
  ServicesSearchProps get props;
}

// Theme:-----------------------------------------------------------------------
abstract class ServicesSearchScreenThemeInterface {
  Color get resultTextColor;
  Color get resultHighlightedTextColor;
}

class ServicesSearchProps {
  final CustomerOrderStoreInterface? customerOrderStore;

  ServicesSearchProps({this.customerOrderStore});
}

// Implementation:--------------------------------------------------------------
class ServicesSearch extends StatefulWidget
    implements ServicesSearchWidgetInterface {
  const ServicesSearch({super.key, required this.props});

  @override
  final ServicesSearchProps props;

  @override
  State<ServicesSearch> createState() => _ServicesSearchState();
}

class _ServicesSearchState extends State<ServicesSearch> {
  // Stores:--------------------------------------------------------------------
  late final ServicesSearchStoreInterface _store =
      getIt<ServicesSearchStoreInterface>();

  // Services:------------------------------------------------------------------
  late final ServiceServiceInterface _serviceService =
      getIt<ServiceServiceInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();
  late final ServicesSearchScreenThemeInterface _theme =
      getIt<ServicesSearchScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        CupertinoSearchTextField(onChanged: _store.setSearch),
        const SizedBox(height: 16),
        _buildHeaders(),
        _buildRows(),
      ],
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeaders() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 50,
        ),
        _buildHeader('services_search.header.family'.tr()),
        // Breadcrumb
        _buildHeader(''),
        _buildHeader('services_search.header.sub_family'.tr()),
        // Breadcrumb
        _buildHeader(''),
        _buildHeader('services_search.header.service'.tr()),
      ],
    );
  }

  Widget _buildHeader(String headerName) {
    return headerName != ''
        ? SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                headerName,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: MapleCommonColors.greyLighter,
                ),
              ),
            ),
          )
        : Container(
            width: 100,
          );
  }

  Widget _buildRows() {
    return Expanded(
      child: Observer(
        builder: (_) {
          if (_store.search.isEmpty) {
            return Container();
          } else {
            return StreamBuilder<List<Service>>(
              stream: _serviceService.searchAsStream(
                _store.searchableSearch,
                eager: true,
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                List<Service> services = snapshot.data;

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return _buildRow(services[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildRow(Service service) {
    return GestureDetector(
      onTap: () => _onServiceTap(service),
      child: Container(
        height: 44,
        decoration: const BoxDecoration(
          color: MapleCommonColors.greyLightest,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 50,
            ),
            _buildCell(cellValue: service.subFamily!.family!.label),
            _buildCell(
                child: Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: _theme.resultTextColor,
            )),
            _buildCell(cellValue: service.subFamily!.label),
            _buildCell(
                child: Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: _theme.resultTextColor,
            )),
            _buildServiceCell(service.label, _store.search),
          ],
        ),
      ),
    );
  }

  Widget _buildCell({String? cellValue, Widget? child}) {
    return cellValue != null
        ? SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                cellValue,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _appThemeData.defaultTextColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        : SizedBox(
            width: 100,
            child: child,
          );
  }

  List<TextSpan> highlightTextOccurences(String text, String query) {
    List<TextSpan> children = [];
    // if query is empty or not found in text, just return texts
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      children.add(TextSpan(
        text: text,
        style: TextStyle(
          color: _theme.resultTextColor,
          fontSize: 13,
        ),
      ));
      return children;
    }
    List<Match> matches =
        query.toLowerCase().allMatches(text.toLowerCase()).toList();

    int lastMatchEndIndex = 0;
    for (var i = 0; i < matches.length; i++) {
      final match = matches[i];
      if (match.start != lastMatchEndIndex) {
        // do not highlight intermediary texts that do not match
        children.add(
          TextSpan(
            text: text.substring(lastMatchEndIndex, match.start),
            style: TextStyle(
              color: _theme.resultTextColor,
              fontSize: 13,
            ),
          ),
        );
      }
      // highlight matched texts
      children.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: TextStyle(
            color: _theme.resultHighlightedTextColor,
            fontSize: 13,
          ),
        ),
      );

      // highlight texts that do not match after last match
      if (i == matches.length - 1 && match.end != text.length) {
        children.add(TextSpan(
          text: text.substring(match.end, text.length),
          style: TextStyle(
            color: _theme.resultTextColor,
            fontSize: 13,
          ),
        ));
      }

      lastMatchEndIndex = match.end;
    }
    return children;
  }

  Widget _buildServiceCell(String cellValue, String query) {
    return Expanded(
      child: Text.rich(
        TextSpan(
          children: highlightTextOccurences(cellValue, query),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onServiceTap(Service service) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<ServiceDialogWidgetInterface>(
        param1: ServiceDialogProps(
          service: service,
          customerOrderStore: widget.props.customerOrderStore,
        ),
      ),
    );
  }
}
