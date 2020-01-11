
import 'package:flutter/material.dart';
import 'package:formatable_text/widgets/formattable_text.dart';

class PhrasePiece {

  final String text;
  final Set<TextStyleTag> tags;

  PhrasePiece({@required this.text, @required this.tags});

  PhrasePiece copy({String text, Set<TextStyleTag> tags}){
    return PhrasePiece(text: text ?? this.text, tags: tags ?? this.tags);
  }

}