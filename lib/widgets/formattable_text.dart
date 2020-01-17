
import 'package:flutter/material.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/utils.dart';

class FormattedText extends StatefulWidget {
  final String phrase;

  FormattedText({@required String phrase}) :this.phrase = phrase ?? '';

  @override
  _FormattedTextState createState() => _FormattedTextState();
}

class _FormattedTextState extends State<FormattedText> {
  @override
  Widget build(BuildContext context) {
    final MergedPhrasePieces phrasePieces = Utils.parseStringFormat(widget.phrase);
    TextStyle parentTextStyle;

    final List<TextSpan> childrenSpans = [];

    for (int index = 0; index < phrasePieces.mergedPhrasePieces.length; index++) {
      final String text = phrasePieces.mergedPhrasePieces[index].text;
      final Set<TextStyleTag> tags = phrasePieces.mergedPhrasePieces[index].tags;

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
