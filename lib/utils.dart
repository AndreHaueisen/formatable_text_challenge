import 'package:flutter/material.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/widgets/formatable_text.dart';
import 'package:collection/collection.dart' as collections;

class Utils {
  static List<PhrasePiece> parseStringFormat(String text) {
    final String pattern =
        "(?<=${Constants.BOLD_TAG})|(?=${Constants.BOLD_TAG})|(?<=${Constants.ITALIC_TAG})|(?=${Constants.ITALIC_TAG})|(?<=${Constants.STRIKETHROUGH_TAG})|(?=${Constants.STRIKETHROUGH_TAG})";

    final List<String> brokenPhrase = text.split(RegExp(pattern));
    List<PhrasePiece> phrasePieces = _generatePiecesFromBrokenPhrase(text, brokenPhrase);

    return phrasePieces;
  }

  static List<PhrasePiece> _generatePiecesFromBrokenPhrase(String originalText, List<String> brokenPhrase) {
    final List<PhrasePiece> phraseWords = [];

    final int lastBoldTagPosition = brokenPhrase.lastIndexOf(Constants.BOLD_TAG);
    final int lastItalicTagPosition = brokenPhrase.lastIndexOf(Constants.ITALIC_TAG);
    final int lastStrikeThroughTagPosition = brokenPhrase.lastIndexOf(Constants.STRIKETHROUGH_TAG);

    final int boldTagsTotalCount = Constants.BOLD_TAG.allMatches(originalText).length;
    final int italicTagsTotalCount = Constants.ITALIC_TAG.allMatches(originalText).length;
    final int strikeThroughTagsTotalCount = Constants.STRIKETHROUGH_TAG.allMatches(originalText).length;

    int index = 0;
    int looseBoldTagIndexPosition = -1;
    int looseItalicTagPosition = -1;
    int looseStrikethroughTagPosition = -1;

    while (index < brokenPhrase.length) {
      int backwardsBoldTagsCount = 0;
      int backwardsItalicTagsCount = 0;
      int backwardsStrikethroughTagsCount = 0;

      final List<String> phraseBeforeWord = brokenPhrase.getRange(0, index).toList(growable: false);

      for (String phrasePiece in phraseBeforeWord) {
        if (_isTag(phrasePiece)) {
          if (phrasePiece == Constants.BOLD_TAG) backwardsBoldTagsCount++;
          if (phrasePiece == Constants.ITALIC_TAG) backwardsItalicTagsCount++;
          if (phrasePiece == Constants.STRIKETHROUGH_TAG) backwardsStrikethroughTagsCount++;
        }
      }

      final String currentWord = brokenPhrase[index];
      final bool isTag = _isTag(currentWord);
      final bool isBoldTag = currentWord == Constants.BOLD_TAG;
      final bool isItalicTag = currentWord == Constants.ITALIC_TAG;
      final bool isStrikethroughTag = currentWord == Constants.STRIKETHROUGH_TAG;

      bool isLastBoldTag = false;
      bool isLastItalicTag = false;
      bool isLastStrikethroughTag = false;

      if (isTag) {
        isLastBoldTag = (isBoldTag && boldTagsTotalCount.isOdd && (lastBoldTagPosition == index));
        isLastItalicTag = (isItalicTag && italicTagsTotalCount.isOdd && (lastItalicTagPosition == index));
        isLastStrikethroughTag = (isStrikethroughTag && strikeThroughTagsTotalCount.isOdd && (lastStrikeThroughTagPosition == index));
      }

      final Set<TextStyleTag> wordTags = _extractWordTags(
        backwardsBoldTagsCount: backwardsBoldTagsCount,
        backwardsItalicTagsCount: backwardsItalicTagsCount,
        backwardsStrikethroughTagsCount: backwardsStrikethroughTagsCount,
        boldTagsTotalCount: boldTagsTotalCount,
        italicTagsTotalCount: italicTagsTotalCount,
        strikeThroughTagsTotalCount: strikeThroughTagsTotalCount,
        position: index,
        lastBoldTagPosition: lastBoldTagPosition,
        lastItalicTagPosition: lastItalicTagPosition,
        lastStrikeThroughTagPosition: lastStrikeThroughTagPosition,
      );

      if (!isTag) {
        phraseWords.add(PhrasePiece(text: currentWord, tags: wordTags));
      } else {
        if (isLastBoldTag) {
          looseBoldTagIndexPosition = lastBoldTagPosition;
        } else if (isLastItalicTag) {
          looseItalicTagPosition = lastItalicTagPosition;
        } else if (isLastStrikethroughTag) {
          looseStrikethroughTagPosition = lastStrikeThroughTagPosition;
        }
      }

      index++;
    }

    final List<PhrasePiece> phrasePieces = [];
    if (phraseWords.length > 1) {
      final totalTagCount = boldTagsTotalCount + italicTagsTotalCount + strikeThroughTagsTotalCount;
      if (looseBoldTagIndexPosition != -1) {
        phraseWords.insert((looseBoldTagIndexPosition - totalTagCount + 1)  , PhrasePiece(text: Constants.BOLD_TAG, tags: {TextStyleTag.NORMAL}));
      }

      if (looseItalicTagPosition != -1) {
        phraseWords.insert((looseItalicTagPosition - totalTagCount + 1), PhrasePiece(text: Constants.ITALIC_TAG, tags: {TextStyleTag.NORMAL}));
      }

      if (looseStrikethroughTagPosition != -1) {
        phraseWords.insert((looseStrikethroughTagPosition - totalTagCount + 1), PhrasePiece(text: Constants.STRIKETHROUGH_TAG, tags: {TextStyleTag.NORMAL}));
      }

      phrasePieces.addAll(_mergePieces(phraseWords: phraseWords));
    } else {
      phrasePieces.addAll(phraseWords);
    }

    return phrasePieces;
  }

  static bool _isTag(String text) {
    return text == Constants.BOLD_TAG || text == Constants.ITALIC_TAG || text == Constants.STRIKETHROUGH_TAG;
  }

  static Set<TextStyleTag> _extractWordTags({
    @required int backwardsBoldTagsCount,
    @required int backwardsItalicTagsCount,
    @required int backwardsStrikethroughTagsCount,
    @required int boldTagsTotalCount,
    @required int italicTagsTotalCount,
    @required int strikeThroughTagsTotalCount,
    @required int position,
    @required int lastBoldTagPosition,
    @required int lastItalicTagPosition,
    @required int lastStrikeThroughTagPosition,
  }) {
    final Set<TextStyleTag> tags = {};

    if (backwardsBoldTagsCount > 0 && backwardsBoldTagsCount.isOdd && position < lastBoldTagPosition) {
      tags.add(TextStyleTag.BOLD);
    }
    if (backwardsItalicTagsCount > 0 && backwardsItalicTagsCount.isOdd && position < lastItalicTagPosition) {
      tags.add(TextStyleTag.ITALIC);
    }
    if (backwardsStrikethroughTagsCount > 0 && backwardsStrikethroughTagsCount.isOdd && position < lastStrikeThroughTagPosition) {
      tags.add(TextStyleTag.STRIKETHROUGH);
    }

    if (tags.isEmpty) {
      tags.add(TextStyleTag.NORMAL);
    }

    return tags;
  }

  static List<PhrasePiece> _mergePieces({@required List<PhrasePiece> phraseWords}) {
    final List<PhrasePiece> phrasePieces = [];
    int index = 0;

    while (index < phraseWords.length) {
      final List<PhrasePiece> phraseSublist = phraseWords.sublist(index + 1);
      PhrasePiece currentPhraseWord;
      PhrasePiece mergedPhrasePiece;
      String mergedText = '';

      for (int i = 0; i < phraseSublist.length; i++) {
        final PhrasePiece phraseWord = phraseSublist[i];
        currentPhraseWord = phraseWords[index];
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
        mergedPhrasePiece = phraseWords[index];
        index++;
      }

      phrasePieces.add(mergedPhrasePiece);
      String textFromPhraseWords = _convertPiecesToString(phraseWords);
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
