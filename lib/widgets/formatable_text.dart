
import 'package:flutter/material.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/utils.dart';

class FormatableText extends StatefulWidget {
  final String phrase;

  FormatableText({@required this.phrase}) : assert(phrase != null);

  @override
  _FormatableTextState createState() => _FormatableTextState();
}

class _FormatableTextState extends State<FormatableText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _buildPhrase() {
    final List<PhrasePiece> questionMapList = Utils.parseStringFormat(widget.phrase);
    TextStyle parentTextStyle;

    final List<TextSpan> childrenSpans = [];

    for (int index = 0; index < questionMapList.length; index++) {
      String text = questionMapList[index].text;
      TextStyleTag tag = questionMapList[index].tags.first;

      childrenSpans.add(TextSpan(text: text, style: _getTextStyleFromTag(tag, fontSize: 16)));
    }

    TextSpan parentSpan = TextSpan(style: parentTextStyle, children: childrenSpans);

    return RichText(
      text: parentSpan,
    );
  }

  /// Returns a text style depending on the TextStyleTag
  TextStyle _getTextStyleFromTag(TextStyleTag tag, {Color color = const Color(0xFF212121), double fontSize = 14}) {
    TextStyle textStyle;

    switch (tag) {
      case TextStyleTag.NORMAL:
        {
          textStyle = TextStyle(fontStyle: FontStyle.normal, color: color, fontSize: fontSize);
          break;
        }
      case TextStyleTag.BOLD:
        {
          textStyle = TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: fontSize);
          break;
        }
      case TextStyleTag.ITALIC:
        {
          textStyle = TextStyle(fontStyle: FontStyle.italic, color: color, fontSize: fontSize);
          break;
        }
      case TextStyleTag.STRIKETHROUGH:
        {
          textStyle = TextStyle(color: color, fontSize: fontSize, decoration: TextDecoration.lineThrough);
        }
    }
    return textStyle;
  }
}

enum TextStyleTag { NORMAL, BOLD, ITALIC, STRIKETHROUGH }
