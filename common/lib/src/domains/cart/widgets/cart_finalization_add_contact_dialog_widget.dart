import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CartFinalizationAddContactDialogWidgetInterface
    implements Widget {
  CartFinalizationAddContactDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class CartFinalizationAddContactDialogProps {
  const CartFinalizationAddContactDialogProps({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class CartFinalizationAddContactDialog extends StatelessWidget
    implements CartFinalizationAddContactDialogWidgetInterface {
  CartFinalizationAddContactDialog({super.key, required this.props});

  @override
  final CartFinalizationAddContactDialogProps props;

  // Services:------------------------------------------------------------------
  final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();

  // Navigators:----------------------------------------------------------------
  final CartAddSelectSignatoryDialogNavigatorInterface _navigator =
      getIt<CartAddSelectSignatoryDialogNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return getIt<CartAddSelectSignatoryDialogWidgetInterface>(
        param1: CartAddSelectSignatoryDialogProps(
          customerOrderStore: props.customerOrderStore,
          selectedValues: props
              .customerOrderStore.finalizationStepStore.selectedContactValues,
          streamForValues: _contactService.getByCustomerIdAsStream(
              props.customerOrderStore.order.customer!.id),
          modalTitle: 'customer_label'.tr(),
          errorModalTitle: 'customer.error_infos.label'.tr(),
          errorModalContent: 'customer.error_infos.content'.tr(),
          errorModalContent2: 'customer.error_infos.content_2'.tr(),
          isContact: true,
          limit: 2,
          onChanged: props.customerOrderStore.finalizationStepStore
              .setSelectedContactValues,
          rightChild: CupertinoButton(
            onPressed: () => _navigator.key.currentState?.pushNamed(
              _navigator.createOrEditContact,
              arguments: CartCreateOrEditContactArguments(
                customer: props.customerOrderStore.order.customer!,
              ),
            ),
            child: SvgPicture.asset(
              MapleCommonAssets.plus,
              width: 20,
              colorFilter: ColorFilter.mode(
                DialogHeaderWidgetInterface.sideDefaultTextStyle.color ??
                    _appThemeData.topBarButtonColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      );
    });
  }
}
