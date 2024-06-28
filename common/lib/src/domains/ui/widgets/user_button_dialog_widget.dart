import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class UserButtonDialogWidgetInterface implements Widget {
  UserButtonDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class UserButtonDialogProps {
  const UserButtonDialogProps({this.iconColor});

  final Color? iconColor;
}

// Implementation:--------------------------------------------------------------
class UserButtonDialog extends StatelessWidget
    implements UserButtonDialogWidgetInterface {
  const UserButtonDialog({
    super.key,
    UserButtonDialogProps? props,
  }) : props = props ?? const UserButtonDialogProps();

  @override
  final UserButtonDialogProps props;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          barrierDismissible: false,
          builder: (context) => getIt<AccountDialogWidgetInterface>(),
        );
      },
      child: SvgPicture.asset(MapleCommonAssets.userCircle,
          colorFilter: ColorFilter.mode(
            props.iconColor ?? CupertinoColors.white,
            BlendMode.srcIn,
          )),
    );
  }
}
