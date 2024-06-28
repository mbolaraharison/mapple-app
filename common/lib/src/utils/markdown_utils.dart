import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Interface:-------------------------------------------------------------------
abstract class MarkdownUtilsInterface {
  List<Widget> parse(String markdown, Map<String, dynamic> replacements);

  List<pw.Widget> parseForPdf(
      String markdown, Map<String, dynamic> replacements);
}

// Implementation:--------------------------------------------------------------
class MarkdownUtils implements MarkdownUtilsInterface {
  @override
  List<Widget> parse(String markdown, Map<String, dynamic> replacements) {
    // Parsers
    var heading = const md.HeaderSyntax();
    var emphasis = md.EmphasisSyntax.asterisk();
    var unorderedList = const md.UnorderedListSyntax();
    var orderedList = const md.OrderedListSyntax();
    var orderedListWithCheckbox = const md.OrderedListWithCheckboxSyntax();
    var link = md.LinkSyntax();
    var lineBreak = md.LineBreakSyntax();
    var document = md.Document(blockSyntaxes: [
      heading,
      unorderedList,
      orderedList,
      orderedListWithCheckbox
    ], inlineSyntaxes: [
      emphasis,
      link,
      lineBreak
    ]);

    final lines = markdown.replaceAll('\r\n', '\n').split('\n');

    final nodes = document.parseLines(lines);

    List<Widget> result = [];

    for (var node in nodes) {
      if (node is md.Element) {
        // Headings
        if (node.tag == 'h1' ||
            node.tag == 'h2' ||
            node.tag == 'h3' ||
            node.tag == 'h4' ||
            node.tag == 'h5' ||
            node.tag == 'h6') {
          String text = node.textContent;
          replacements.forEach((key, value) {
            text = text.replaceAll(RegExp('{$key}'), value);
          });
          double fontSize = 12;
          switch (node.tag) {
            case 'h1':
              fontSize = 30;
              break;
            case 'h2':
              fontSize = 28;
              break;
            case 'h3':
              fontSize = 26;
              break;
            case 'h4':
              fontSize = 23;
              break;
            case 'h5':
              fontSize = 20;
              break;
            default:
              fontSize = 18;
              break;
          }
          result.add(Text(text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              )));
          result.add(const SizedBox(height: 10));
        }
        // Paragraphs
        if (node.tag == 'p') {
          var richTextChildren = <InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            if (element is md.Element) {
              // Emphasis (italic) => _text_
              if (element.tag == 'em') {
                richTextChildren.add(TextSpan(
                    text: text,
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic)));
              }
              // Strong (bold) => **text**
              if (element.tag == 'strong') {
                richTextChildren.add(TextSpan(
                    text: text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)));
              }
              // Underline => [text](url)
              if (element.tag == 'a') {
                richTextChildren.add(TextSpan(
                    text: element.textContent,
                    style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline)));
              }
            } else {
              richTextChildren.add(TextSpan(
                  text: text,
                  style: const TextStyle(
                    fontSize: 16,
                  )));
            }
          }
          result.add(RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: richTextChildren,
            ),
          ));
          result.add(const SizedBox(height: 10));
        }
        // Unordered lists
        if (node.tag == 'ul') {
          var richTextChildren = <InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            if (element is md.Element) {
              if (element.tag == 'li') {
                richTextChildren.add(const TextSpan(
                    text: '- ',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
                richTextChildren.add(TextSpan(
                    text: '$text\n', style: const TextStyle(fontSize: 16)));
              }
            }
          }
          result.add(
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: richTextChildren,
                ),
              ),
            ),
          );
        }
        // Ordered lists
        if (node.tag == 'ol') {
          var richTextChildren = <InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            int index = node.children!.indexOf(element) + 1;
            if (element is md.Element) {
              if (element.tag == 'li') {
                RegExpMatch? match = RegExp(r'^\d-').firstMatch(text);
                String prefix = '$index- ';
                if (match != null) {
                  prefix = match[0]!;
                }
                text = text.replaceAllMapped(RegExp(r'^\d-'), (match) => '');
                richTextChildren.add(TextSpan(
                    text: prefix,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)));
                richTextChildren.add(TextSpan(
                    text: '$text\n', style: const TextStyle(fontSize: 16)));
              }
            }
          }
          result.add(
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: richTextChildren,
                ),
              ),
            ),
          );
        }
      }
    }
    return result;
  }

  @override
  List<pw.Widget> parseForPdf(
      String markdown, Map<String, dynamic> replacements) {
    // Parsers
    var heading = const md.HeaderSyntax();
    var emphasis = md.EmphasisSyntax.asterisk();
    var unorderedList = const md.UnorderedListSyntax();
    var orderedList = const md.OrderedListSyntax();
    var link = md.LinkSyntax();
    var document = md.Document(
        blockSyntaxes: [heading, unorderedList, orderedList],
        inlineSyntaxes: [emphasis, link]);

    final lines = markdown.replaceAll('\r\n', '\n').split('\n');

    final nodes = document.parseLines(lines);

    List<pw.Widget> result = [];

    for (var node in nodes) {
      if (node is md.Element) {
        // Headings
        if (node.tag == 'h1' ||
            node.tag == 'h2' ||
            node.tag == 'h3' ||
            node.tag == 'h4' ||
            node.tag == 'h5' ||
            node.tag == 'h6') {
          String text = node.textContent;
          replacements.forEach((key, value) {
            text = text.replaceAll(RegExp('{$key}'), value);
          });
          double fontSize = 12;
          switch (node.tag) {
            case 'h1':
              fontSize = 25;
              break;
            case 'h2':
              fontSize = 22;
              break;
            case 'h3':
              fontSize = 20;
              break;
            case 'h4':
              fontSize = 18;
              break;
            case 'h5':
              fontSize = 15;
              break;
            default:
              fontSize = 12;
              break;
          }
          result.add(pw.Text(text,
              style: pw.TextStyle(
                  fontSize: fontSize,
                  fontWeight: pw.FontWeight.bold,
                  lineSpacing: 5)));
        }
        // Paragraphs
        if (node.tag == 'p') {
          var richTextChildren = <pw.InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            if (element is md.Element) {
              // Emphasis (italic) => _text_
              if (element.tag == 'em') {
                richTextChildren.add(pw.TextSpan(
                    text: text,
                    style: pw.TextStyle(
                        fontSize: 10, fontStyle: pw.FontStyle.italic)));
              }
              // Strong (bold) => **text**
              if (element.tag == 'strong') {
                richTextChildren.add(pw.TextSpan(
                    text: text,
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.bold)));
              }
              // Underline => [text](url)
              if (element.tag == 'a') {
                richTextChildren.add(pw.TextSpan(
                    text: text,
                    style: pw.TextStyle(
                        fontSize: 10,
                        fontStyle: pw.FontStyle.italic,
                        decoration: pw.TextDecoration.underline)));
              }
            } else {
              richTextChildren.add(pw.TextSpan(
                  text: text, style: const pw.TextStyle(fontSize: 10)));
            }
          }
          result.add(pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex('#000000'),
                  lineSpacing: 2),
              children: richTextChildren,
            ),
          ));
        }
        // Unordered lists
        if (node.tag == 'ul') {
          var richTextChildren = <pw.InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            if (element is md.Element) {
              if (element.tag == 'li') {
                richTextChildren.add(pw.TextSpan(
                    text: '- ',
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.bold)));
                richTextChildren.add(pw.TextSpan(
                    text: '$text\n', style: const pw.TextStyle(fontSize: 10)));
              }
            }
          }
          result.add(
            pw.Container(
              padding: const pw.EdgeInsets.only(left: 20),
              child: pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromHex('#000000'),
                      lineSpacing: 2),
                  children: richTextChildren,
                ),
              ),
            ),
          );
        }
        // Ordered lists
        if (node.tag == 'ol') {
          var richTextChildren = <pw.InlineSpan>[];
          for (var element in node.children!) {
            String text = element.textContent;
            replacements.forEach((key, value) {
              text = text.replaceAll(RegExp('{$key}'), value);
            });
            int index = node.children!.indexOf(element) + 1;
            if (element is md.Element) {
              if (element.tag == 'li') {
                RegExpMatch? match = RegExp(r'^\d-').firstMatch(text);
                String prefix = '$index- ';
                if (match != null) {
                  prefix = match[0]!;
                }
                text = text.replaceAllMapped(RegExp(r'^\d-'), (match) => '');
                richTextChildren.add(pw.TextSpan(
                    text: prefix,
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.bold)));
                richTextChildren.add(pw.TextSpan(
                    text: '$text\n', style: const pw.TextStyle(fontSize: 10)));
              }
            }
          }
          result.add(
            pw.Container(
              padding: const pw.EdgeInsets.only(left: 10),
              child: pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromHex('#000000'),
                      lineSpacing: 2),
                  children: richTextChildren,
                ),
              ),
            ),
          );
        }
        result.add(pw.SizedBox(height: 10));
      }
    }
    return result;
  }
}
