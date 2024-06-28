import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfCheckboxWidgetInterface implements Widget {
  PdfCheckboxProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfCheckboxProps {
  PdfCheckboxProps({
    required this.isChecked,
    this.label,
    this.labelSize = 8,
    this.labelWidth,
    this.checkboxSize = 10,
  });

  final bool isChecked;
  final String? label;
  final double labelSize;
  final double? labelWidth;
  final double checkboxSize;
}

// Implementation:--------------------------------------------------------------
class PdfCheckbox extends StatelessWidget
    implements PdfCheckboxWidgetInterface {
  PdfCheckbox({
    required this.props,
  });

  @override
  final PdfCheckboxProps props;

  @override
  Widget build(Context context) {
    final checkbox = Container(
      width: props.checkboxSize,
      height: props.checkboxSize,
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black),
      ),
      child: props.isChecked
          ? Center(
              child: Text(
                'X',
                style: const TextStyle(fontSize: 9),
              ),
            )
          : Container(),
    );

    if (props.label == null) {
      return checkbox;
    }

    return Row(
      children: [
        checkbox,
        SizedBox(width: 4),
        SizedBox(
          width: props.labelWidth,
          child: Text(
            props.label!,
            style: TextStyle(fontSize: props.labelSize),
          ),
        ),
      ],
    );
  }
}
