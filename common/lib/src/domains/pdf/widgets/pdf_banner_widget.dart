import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class PdfBannerWidgetInterface implements Widget {
  PdfBannerProps get props;
}

// Props:-----------------------------------------------------------------------
class PdfBannerProps {
  PdfBannerProps({
    required this.backgroundColor,
    required this.content,
    this.fontSize = 12,
    this.verticalPadding = 4,
  });

  final PdfColor backgroundColor;
  final String content;
  final double fontSize;
  final double verticalPadding;
}

// Implementation:--------------------------------------------------------------
class PdfBanner extends StatelessWidget implements PdfBannerWidgetInterface {
  PdfBanner({
    required this.props,
  });

  @override
  final PdfBannerProps props;

  @override
  Widget build(Context context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: props.verticalPadding),
      color: props.backgroundColor,
      child: Center(
        child: Text(
          props.content,
          style: TextStyle(
            fontSize: props.fontSize,
            color: PdfColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
