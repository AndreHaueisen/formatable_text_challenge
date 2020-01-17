import 'package:flutter/material.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/phrase_data.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/models/tag.dart';
import 'package:formatable_text/models/tags_before_word_counter.dart';
import 'package:formatable_text/widgets/formattable_text.dart';

class Utils {
  const Utils._();

  static MergedPhrasePieces parseStringFormat(String originalPhrase) {
    final List<String> brokenPhrase = originalPhrase.split(RegExp(Constants.SPLIT_PATTERN));
    final List<PhrasePiece> phrasePieces = _generatePiecesFromBrokenPhrase(originalPhrase, brokenPhrase);

    // this is done to improve performance when drawing the ui
    final MergedPhrasePieces mergedPhrasePieces = MergedPhrasePieces.fromPieces(phrasePieces);

    return mergedPhrasePieces;
  }

  static List<PhrasePiece> _generatePiecesFromBrokenPhrase(String originalPhrase, List<String> brokenPhrase) {
    final List<PhrasePiece> phrasePieces = [];
    final PhraseData phraseData = PhraseData.fromOriginalPhrase(originalPhrase);

    int looseBoldTagPosition = -1;
    int looseItalicTagPosition = -1;
    int looseStrikethroughTagPosition = -1;

    int index = 0;
    while (index < brokenPhrase.length) {
      final String text = brokenPhrase[index];
      final TagsBeforeWordCounter tagsBeforeWordCounter = TagsBeforeWordCounter.fromBrokenPhrase(
        brokenPhrase: brokenPhrase,
        wordPosition: index,
      );

      PhrasePiece currentPiece = PhrasePiece.intoTagOrPiece(
        text: text,
        phraseData: phraseData,
        textPositionInPhrase: index,
        tagsBeforeWordCounter: tagsBeforeWordCounter,
      );

      if ((currentPiece is Tag)) {
        if (currentPiece.isLastBoldTag) {
          looseBoldTagPosition = phraseData.lastBoldTagPosition;
        } else if (currentPiece.isLastItalicTag) {
          looseItalicTagPosition = phraseData.lastItalicTagPosition;
        } else if (currentPiece.isLastStrikethroughTag) {
          looseStrikethroughTagPosition = phraseData.lastStrikeThroughTagPosition;
        }
      } else {
        phrasePieces.add(currentPiece);
      }

      index++;
    }

    // Adds a loose tag back to the phrase in case there is one
    // A loose tag is a tag without its pair
    _insertLooseTagsIntoPhrasePieces(
      phrasePieces: phrasePieces,
      phraseData: phraseData,
      looseBoldTagPosition: looseBoldTagPosition,
      looseItalicTagPosition: looseItalicTagPosition,
      looseStrikethroughTagPosition: looseStrikethroughTagPosition,
    );

    return phrasePieces;
  }

  static void _insertLooseTagsIntoPhrasePieces({
    @required List<PhrasePiece> phrasePieces,
    @required PhraseData phraseData,
    @required int looseBoldTagPosition,
    @required int looseItalicTagPosition,
    @required int looseStrikethroughTagPosition,
  }) {
    int insertPosition;
    if (looseBoldTagPosition != -1) {
      insertPosition = looseBoldTagPosition - phraseData.totalTagCount + 1;
      phrasePieces.insert(insertPosition.abs(), PhrasePiece(text: Constants.BOLD_TAG, tags: {TextStyleTag.NORMAL}));
    }

    if (looseItalicTagPosition != -1) {
      insertPosition = looseItalicTagPosition - phraseData.totalTagCount + 1;
      phrasePieces.insert(insertPosition.abs(), PhrasePiece(text: Constants.ITALIC_TAG, tags: {TextStyleTag.NORMAL}));
    }

    if (looseStrikethroughTagPosition != -1) {
      insertPosition = looseStrikethroughTagPosition - phraseData.totalTagCount + 1;
      phrasePieces.insert(insertPosition.abs(), PhrasePiece(text: Constants.STRIKETHROUGH_TAG, tags: {TextStyleTag.NORMAL}));
    }
  }
}
