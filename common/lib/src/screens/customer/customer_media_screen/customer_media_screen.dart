import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerMediaScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CustomerMediaScreen extends StatefulWidget
    implements CustomerMediaScreenInterface {
  const CustomerMediaScreen({super.key});

  @override
  State<CustomerMediaScreen> createState() => _CustomerMediaScreenState();
}

class _CustomerMediaScreenState extends State<CustomerMediaScreen>
    with TickerProviderStateMixin {
  // Stores:--------------------------------------------------------------------
  late final CustomerMediaStoreInterface _store =
      getIt<CustomerMediaStoreInterface>();

  // Animation:-----------------------------------------------------------------
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  late double columnWidth;

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    columnWidth =
        (MediaQuery.of(context).size.width - SidebarWidgetInterface.width) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Container(
        color: CupertinoColors.extraLightBackgroundGray,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(width: columnWidth),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Stack(
                    children: [
                      _buildMedia(),
                    ],
                  ),
                ),
              ],
            ),
            _buildFirstLevelCategories(),
          ],
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildFirstLevelCategories() {
    final children = _store.mediaFamilies.map((FileDataFamily mediaFamily) {
      return _buildFirstLevelCategoryItem(mediaFamily);
    }).toList();

    return Container(
      width: columnWidth,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 14),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          right: BorderSide(
            color: MapleCommonColors.greyLighter.withOpacity(.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    MapleCommonAssets.backCircle,
                    height: 33,
                    colorFilter: ColorFilter.mode(
                      _appThemeData.topBarButtonColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: Text(
                  'media.title'.tr(),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          getIt<SeparatorWidgetInterface>(
            param1: SeparatorProps(
              color: CupertinoColors.opaqueSeparator.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFirstLevelCategoryItem(
    FileDataFamily mediaFamily,
  ) {
    final bool isSelected = _store.mediaFamily != null
        ? _store.mediaFamily!.id == mediaFamily.id
        : false;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (isSelected) {
          return;
        }
        _store.setMediaFamily(mediaFamily);
        _controller.forward();
      },
      child: Container(
        height: 81,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(mediaFamily.backgroundImage, fit: BoxFit.cover),
            Center(
              child: Row(
                children: [
                  const SizedBox(width: 21),
                  SvgPicture.asset(mediaFamily.icon, height: 23),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      mediaFamily.label,
                      style: const TextStyle(
                        fontSize: 19,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: isSelected
                        ? CupertinoColors.white
                        : CupertinoColors.white.withOpacity(.5),
                  ),
                  const SizedBox(width: 13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia() {
    return Observer(builder: ((context) {
      if (_store.mediaFamily == null) {
        return Container();
      }

      return Container(
        width: columnWidth * 2,
        padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 27),
        decoration: BoxDecoration(
          color: MapleCommonColors.greyLightest,
          border: Border(
            right: BorderSide(
              color: MapleCommonColors.greyLighter.withOpacity(.5),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _store.mediaFamily!.label,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 9),
                  getIt<SeparatorWidgetInterface>(
                    param1: SeparatorProps(
                      color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Expanded(
              child: Observer(builder: (context) {
                return GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: _store.mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    return getIt<MediaCardWidgetInterface>(
                      param1: MediaCardProps(medium: _store.mediaList[index]),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    }));
  }
}
