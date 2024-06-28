import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class FasciaBoardTabWidgetInterface implements Widget {
  FasciaBoardTabProps get props;
}

// Props:-----------------------------------------------------------------------
class FasciaBoardTabProps {
  const FasciaBoardTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class FasciaBoardTab extends StatefulWidget
    implements FasciaBoardTabWidgetInterface {
  const FasciaBoardTab({super.key, required this.props});

  @override
  final FasciaBoardTabProps props;

  @override
  State<FasciaBoardTab> createState() => _FasciaBoardTabState();
}

class _FasciaBoardTabState extends State<FasciaBoardTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _fasciaBoardLengthController =
      TextEditingController();
  final TextEditingController _fasciaBoardAdvanceInCmController =
      TextEditingController();
  final TextEditingController _fasciaBoardColorController =
      TextEditingController();
  final TextEditingController _fasciaBoardReturnController =
      TextEditingController();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _fasciaBoardLengthController.text =
        widget.props.store.siteSheet?.fasciaBoardLength ?? '';
    _fasciaBoardAdvanceInCmController.text =
        widget.props.store.siteSheet?.fasciaBoardAdvanceInCm ?? '';
    _fasciaBoardColorController.text =
        widget.props.store.siteSheet?.fasciaBoardColor ?? '';
    _fasciaBoardReturnController.text =
        widget.props.store.siteSheet?.fasciaBoardReturn ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.fascia_board.fascia_board_length'.tr(),
            textAlign: TextAlign.right,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            controller: _fasciaBoardLengthController,
            withDebounce: true,
            debounceKey: 'fasciaBoardLength',
            onChanged: widget.props.store.setFasciaBoardLength,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.fascia_board.fascia_board_advance_in_cm'
                .tr(),
            textAlign: TextAlign.right,
            controller: _fasciaBoardAdvanceInCmController,
            withDebounce: true,
            debounceKey: 'fasciaBoardAdvanceInCm',
            onChanged: widget.props.store.setFasciaBoardAdvanceInCm,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.fascia_board.fascia_board_color'.tr(),
            textAlign: TextAlign.right,
            controller: _fasciaBoardColorController,
            withDebounce: true,
            debounceKey: 'fasciaBoardColor',
            onChanged: widget.props.store.setFasciaBoardColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.fascia_board.fascia_board_return'.tr(),
            textAlign: TextAlign.right,
            controller: _fasciaBoardReturnController,
            withDebounce: true,
            debounceKey: 'fasciaBoardReturn',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setFasciaBoardReturn,
          ),
        ),
      ],
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _fasciaBoardLengthController.dispose();
    _fasciaBoardAdvanceInCmController.dispose();
    _fasciaBoardColorController.dispose();
    _fasciaBoardReturnController.dispose();
    super.dispose();
  }
}
