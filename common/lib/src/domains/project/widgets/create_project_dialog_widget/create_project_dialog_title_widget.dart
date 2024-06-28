import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CreateProjectDialogTitleWidgetInterface implements Widget {
  CreateProjectDialogTitleProps get props;
}

// Props:-----------------------------------------------------------------------
class CreateProjectDialogTitleProps {
  CreateProjectDialogTitleProps({
    required this.title,
    required this.step,
  });

  final String title;
  final int step;
}

// Implementation:--------------------------------------------------------------
class CreateProjectDialogTitle extends StatelessWidget
    implements CreateProjectDialogTitleWidgetInterface {
  CreateProjectDialogTitle({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final CreateProjectDialogTitleProps props;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      margin: const EdgeInsets.symmetric(vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _appThemeData.defaultTextColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              props.step.toString(),
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            props.title,
            style: TextStyle(
              fontSize: 17,
              color: _appThemeData.defaultTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
