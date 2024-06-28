import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfTextFieldWidgetInterface implements Widget {
  PdfTextFieldProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfTextFieldProps {
  PdfTextFieldProps({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

// Implementation:--------------------------------------------------------------
class PdfTextField extends StatelessWidget
    implements PdfTextFieldWidgetInterface {
  PdfTextField({
    required this.props,
  });

  @override
  final PdfTextFieldProps props;

  @override
  Widget build(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${props.label} : ',
          style: const TextStyle(fontSize: 10),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            props.value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
