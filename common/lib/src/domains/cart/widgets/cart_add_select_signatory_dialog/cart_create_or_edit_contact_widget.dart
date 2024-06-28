import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartCreateOrEditContactWidgetInterface implements Widget {
  CartCreateOrEditContactArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class CartCreateOrEditContact extends StatefulWidget
    implements CartCreateOrEditContactWidgetInterface {
  const CartCreateOrEditContact({super.key, required this.arguments});

  @override
  final CartCreateOrEditContactArguments arguments;

  @override
  State<CartCreateOrEditContact> createState() =>
      _CartCreateOrEditContactState();
}

class _CartCreateOrEditContactState extends State<CartCreateOrEditContact> {
  // Services:------------------------------------------------------------------
  final OrderServiceInterface _orderService = getIt<OrderServiceInterface>();
  // Stores:--------------------------------------------------------------------
  late final ContactFormStoreInterface _store =
      getIt<ContactFormStoreInterface>(
    param1: ContactFormStoreParams(
      contact: widget.arguments.contact,
      customer: widget.arguments.customer,
    ),
  );

  late CustomerOrderStoreInterface _customerOrderStore;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customerOrderStore = Provider.of<CustomerOrderStoreInterface>(context);
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            const SizedBox(height: 39),
            getIt<ContactFormWidgetInterface>(
              param1: ContactFormProps(
                  store: _store,
                  onPreDelete: (Contact contact) async {
                    await _orderService.deleteContact(
                      _customerOrderStore.order,
                      contact,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: Wrap(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'back'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          _store.params.contact == null
              ? 'home_create_project_dialog_add_contact'.tr()
              : 'home_create_project_dialog_edit_contact'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (context) {
            return CupertinoButton(
              onPressed: _store.isValid ? _onPressedSubmit : null,
              child: Text(
                _store.params.contact == null ? 'add'.tr() : 'edit'.tr(),
                style: _store.isValid
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        .copyWith(fontWeight: FontWeight.w600)
                    : const TextStyle(
                        color: CupertinoColors.inactiveGray,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onPressedSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    _store.validateForm();

    try {
      _store.errorStore.throwIfError();
    } on ValidationException catch (e) {
      _store.errorStore.showErrorDialog(e.message, context);
      return;
    }

    _store.submit();
    Navigator.pop(context);
  }
}
