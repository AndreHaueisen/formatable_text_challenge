import 'package:collection/collection.dart' as collections;
import 'package:flutter/foundation.dart';
import 'package:formatable_text/models/phrase_piece.dart';

class MergedPhrasePieces {

  final List<PhrasePiece> mergedPhrasePieces;

  MergedPhrasePieces({@required this.mergedPhrasePieces});

  factory MergedPhrasePieces.fromPieces(List<PhrasePiece> pieces){
    return MergedPhrasePieces(mergedPhrasePieces: _mergePieces(pieces: pieces));
  }

  static List<PhrasePiece> _mergePieces({@required List<PhrasePiece> pieces}) {
    final List<PhrasePiece> phrasePieces = [];
    int index = 0;

    while (index < pieces.length) {
      final List<PhrasePiece> phraseSublist = pieces.sublist(index + 1);
      PhrasePiece currentPhraseWord;
      PhrasePiece mergedPhrasePiece;
      String mergedText = '';

      for (int i = 0; i < phraseSublist.length; i++) {
        final PhrasePiece phraseWord = phraseSublist[i];
        currentPhraseWord = pieces[index];
        final bool areTagsEqual = const collections.SetEquality().equals(currentPhraseWord.tags, phraseWord.tags);
        if (areTagsEqual) {
          mergedText += currentPhraseWord.text;
          if (i == phraseSublist.length - 1) {
            mergedText += phraseWord.text;
          }
          mergedPhrasePiece = currentPhraseWord.copy(text: mergedText);
          index++;
        } else {
          break;
        }
      }

      if (mergedPhrasePiece == null) {
        mergedPhrasePiece = pieces[index];
        index++;
      }

      phrasePieces.add(mergedPhrasePiece);
      String textFromPhraseWords = _convertPiecesToString(pieces);
      String textFromPhrasePieces = _convertPiecesToString(phrasePieces);

      if (textFromPhraseWords == textFromPhrasePieces) break;
    }

    return phrasePieces;
  }

  static String _convertPiecesToString(List<PhrasePiece> pieces) {
    String text = '';
    for (PhrasePiece piece in pieces) {
      text += piece.text;
    }
    return text;
  }
}