import 'package:maple_common/maple_common.dart';
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfSelectWidgetInterface implements Widget {
  PdfSelectProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfSelectProps {
  PdfSelectProps({
    required this.label,
    this.labelSize = 10,
    this.valuesSize = 8,
    this.labelWidth,
    this.valuesWidth,
    this.checkboxSize = 10,
    this.spacing = 8,
    required this.values,
  });

  final String label;
  final double labelSize;
  final double? labelWidth;
  final double valuesSize;
  final double? valuesWidth;
  final double checkboxSize;
  final double spacing;
  final List<PdfSelectValue> values;
}

// Implementation:--------------------------------------------------------------
class PdfSelect extends StatelessWidget implements PdfSelectWidgetInterface {
  PdfSelect({
    required this.props,
  });

  @override
  final PdfSelectProps props;

  @override
  Widget build(Context context) {
    final children = props.values
        .map(
          (e) => Container(
            width: props.valuesWidth,
            child: getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: e.value,
                isChecked: e.isChecked,
                labelSize: props.valuesSize,
                checkboxSize: props.checkboxSize,
              ),
            ),
          ),
        )
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: props.labelWidth,
          child: Text(
            '${props.label} : ',
            style: TextStyle(fontSize: props.labelSize),
          ),
        ),
        SizedBox(width: props.spacing),
        Expanded(
          child: props.valuesWidth != null
              ? Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: children,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
        ),
      ],
    );
  }
}
