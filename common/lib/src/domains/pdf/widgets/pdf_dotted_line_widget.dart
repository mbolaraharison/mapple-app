import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfDottedLineWidgetInterface implements Widget {
  PdfDottedLineProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfDottedLineProps {
  PdfDottedLineProps({
    this.color = PdfColors.black,
    this.lineHeiht = 10,
    this.width,
    this.placeholder,
  });

  final PdfColor color;
  final double lineHeiht;
  final double? width;
  final String? placeholder;
}

// Implementation:--------------------------------------------------------------
class PdfDottedLine extends StatelessWidget
    implements PdfDottedLineWidgetInterface {
  PdfDottedLine({
    PdfDottedLineProps? props,
  }) : props = props ?? PdfDottedLineProps();

  @override
  final PdfDottedLineProps props;

  @override
  Widget build(Context context) {
    return Container(
      width: props.width,
      height: props.lineHeiht,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: .5,
            style: BorderStyle.dotted,
            color: props.color,
          ),
        ),
      ),
      child: props.placeholder == null
          ? null
          : Center(
              child: Text(
                props.placeholder!,
                style: TextStyle(
                  color: PdfColors.grey300,
                  fontSize: 8,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
    );
  }
}
