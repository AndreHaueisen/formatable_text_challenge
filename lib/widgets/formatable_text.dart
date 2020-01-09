
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
    return _buildPhrase();
  }

  Widget _buildPhrase() {
    final List<PhrasePiece> parsedString = Utils.parseStringFormat(widget.phrase);
    TextStyle parentTextStyle;

    final List<TextSpan> childrenSpans = [];

    for (int index = 0; index < parsedString.length; index++) {
      final String text = parsedString[index].text;
      final Set<TextStyleTag> tags = parsedString[index].tags;

      childrenSpans.add(TextSpan(text: text, style: _getTextStyleFromTags(tags, fontSize: 16)));
    }

    TextSpan parentSpan = TextSpan(style: parentTextStyle, children: childrenSpans);

    return RichText(
      text: parentSpan,
    );
  }

  TextStyle _getTextStyleFromTags(Set<TextStyleTag> tags, {Color color = const Color(0xFF212121), double fontSize = 14}) {

    FontWeight fontWeight;
    FontStyle fontStyle;
    TextDecoration decoration;

    for(TextStyleTag tag in tags){
      if(tag == TextStyleTag.NORMAL){
        fontStyle = FontStyle.normal;
      } else if (tag == TextStyleTag.BOLD){
        fontWeight = FontWeight.w600;
      } else if (tag == TextStyleTag.ITALIC){
        fontStyle = FontStyle.italic;
      } else if (tag == TextStyleTag.STRIKETHROUGH){
        decoration = TextDecoration.lineThrough;
      }
    }

    return TextStyle(fontWeight: fontWeight, fontStyle: fontStyle, color: color, fontSize: fontSize, decoration: decoration);
  }
}

enum TextStyleTag { NORMAL, BOLD, ITALIC, STRIKETHROUGH }
