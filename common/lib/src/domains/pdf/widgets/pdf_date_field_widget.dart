import 'package:maple_common/maple_common.dart';
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfDateFieldWidgetInterface implements Widget {
  PdfDateFieldProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfDateFieldProps {
  PdfDateFieldProps({
    this.fontSize = 10,
  });

  final double fontSize;
}

// Implementation:--------------------------------------------------------------
class PdfDateField extends StatelessWidget
    implements PdfDateFieldWidgetInterface {
  PdfDateField({
    required this.props,
  });

  @override
  final PdfDateFieldProps props;

  @override
  Widget build(Context context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        getIt<PdfDottedLineWidgetInterface>(
          param1: PdfDottedLineProps(
            width: 15,
            lineHeiht: props.fontSize,
          ),
        ),
        SizedBox(width: 2),
        Text(
          '/',
          style: TextStyle(fontSize: props.fontSize),
        ),
        getIt<PdfDottedLineWidgetInterface>(
          param1: PdfDottedLineProps(
            width: 15,
            lineHeiht: props.fontSize,
          ),
        ),
        SizedBox(width: 2),
        Text(
          '/',
          style: TextStyle(fontSize: props.fontSize),
        ),
        getIt<PdfDottedLineWidgetInterface>(
          param1: PdfDottedLineProps(
            width: 30,
            lineHeiht: props.fontSize,
          ),
        ),
      ],
    );
  }
}
