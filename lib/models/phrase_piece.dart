
import 'package:flutter/material.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

class PhrasePiece {

  final String text;
  final Set<TextStyleTag> tags;

  PhrasePiece({@required this.text, @required this.tags});

  //PhrasePiece.empty(): this.text = '', this.tags = {};

  PhrasePiece copy({String text, Set<TextStyleTag> tags}){
    return PhrasePiece(text: text ?? this.text, tags: tags ?? this.tags);
  }

}