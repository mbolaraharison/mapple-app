import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class AddressWidgetInterface implements Widget {
  AddressProps get props;
}

// Props:-----------------------------------------------------------------------
class AddressProps {
  const AddressProps({
    required this.store,
  });

  final AbstractAddressStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class Address extends StatefulWidget implements AddressWidgetInterface {
  // Constructor:---------------------------------------------------------------
  const Address({super.key, required this.props});

  // Properties:----------------------------------------------------------------
  @override
  final AddressProps props;

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: AddressAutocompleteForm(
            onSelected: (details) {
              Navigator.pop(context);
              widget.props.store.setAddress(details);
            },
          ),
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
          child: Row(
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
          'address'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }
}
