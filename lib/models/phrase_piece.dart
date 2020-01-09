
import 'package:flutter/material.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

import '../constants.dart';

class PhrasePiece {

  static final String _pattern = "${Constants.BOLD_TAG}|${Constants.ITALIC_TAG}|${Constants.STRIKETHROUGH_TAG}";

  final List<int> positions;

  final String text;
  final Set<TextStyleTag> tags;

  PhrasePiece({@required this.positions, @required this.text, @required this.tags});

  PhrasePiece.fromBrokenPhrase({this.positions, @required this.tags, @required List<String> brokenPhrase})
      : this.text = brokenPhrase.sublist(positions.first, positions.last + 1).join().replaceAll(RegExp(_pattern), '');


  bool isBetween(PhrasePiece other){
    return (this.positions.first > other.positions.first) && (this.positions.last < other.positions.last);
  }

  void insertOuterTags(List<PhrasePiece> pieces){
    for(PhrasePiece piece in pieces){
      if(this.isBetween(piece)){
        this.tags.addAll(piece.tags);
      }
    }
  }
}