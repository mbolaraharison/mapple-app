import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class BadgeDialogWidgetInterface implements Widget {
  BadgeDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class BadgeDialogProps {
  const BadgeDialogProps({
    required this.icon,
    required this.description,
    this.width,
    this.height,
  });

  final String icon;
  final String description;
  final double? width;
  final double? height;
}

// Implementation:--------------------------------------------------------------
class BadgeDialog extends StatelessWidget
    implements BadgeDialogWidgetInterface {
  BadgeDialog({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final BadgeDialogProps props;

  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
          width: 350,
          height: 230,
          header: _buildHeader(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _buildContent(),
          ),
          physics: const BouncingScrollPhysics(
              parent: NeverScrollableScrollPhysics())),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        rightContent: CupertinoButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'close'.tr(),
            style: TextStyle(
              color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(props.icon, width: props.width, height: props.height),
        const SizedBox(height: 16),
        AutoSizeText(props.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: _appThemeData.defaultTextColor,
            ))
      ],
    );
  }
}
