import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServicesFloatingButtonsWidgetInterface implements Widget {
  ServicesFloatingButtonsProps get props;
}

class ServicesFloatingButtonsProps {
  final CustomerOrderStoreInterface? customerOrderStore;
  final Function()? onSearchButtonPressed;
  final Function()? onCartButtonPressed;

  ServicesFloatingButtonsProps({
    this.customerOrderStore,
    this.onSearchButtonPressed,
    this.onCartButtonPressed,
  });
}

// Implementation:--------------------------------------------------------------
class ServicesFloatingButtons extends StatelessWidget
    implements ServicesFloatingButtonsWidgetInterface {
  ServicesFloatingButtons({super.key, required this.props});

  @override
  final ServicesFloatingButtonsProps props;

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: props.onSearchButtonPressed,
          backgroundColor: _appThemeData.serviceFloatingButtonColor,
          child: const Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Icon(
                CupertinoIcons.search,
                color: CupertinoColors.white,
                size: 32,
              ),
            ],
          ),
        ),
        props.customerOrderStore != null
            ? const SizedBox(height: 16)
            : const SizedBox(),
        props.customerOrderStore != null
            ? FloatingActionButton(
                onPressed: props.onCartButtonPressed,
                backgroundColor: _appThemeData.serviceFloatingButtonColor,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      MapleCommonAssets.cart,
                      colorFilter: const ColorFilter.mode(
                        CupertinoColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: -5,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _appThemeData.buttonColor,
                          border: Border.all(
                            color: CupertinoColors.white,
                            width: 1,
                          ),
                        ),
                        width: 20,
                        child: Observer(builder: (_) {
                          return Text(
                            props.customerOrderStore!.orderStepStore.orderRows
                                .length
                                .toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.white,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
