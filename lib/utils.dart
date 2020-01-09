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
    List<PhrasePiece> phrasePieces = generatePiecesFromBrokenPhrase(brokenPhrase);

    return phrasePieces;
  }

  static List<PhrasePiece> generatePiecesFromBrokenPhrase(List<String> brokenPhrase) {
    final List<PhrasePiece> phraseWords = [];
    int index = 0;

    while (index < brokenPhrase.length) {
      int backwardsBoldTagsCount = 0;
      int backwardsItalicTagsCount = 0;
      int backwardsStrikethroughTagsCount = 0;

      int forwardsBoldTagsCount = 0;
      int forwardsItalicTagsCount = 0;
      int forwardsStrikethroughTagsCount = 0;

      List<String> phraseBeforeWord = brokenPhrase.getRange(0, index).toList(growable: false);
      List<String> phraseAfterWord = brokenPhrase.getRange(index, brokenPhrase.length).toList(growable: false);

      for (String phrasePiece in phraseBeforeWord) {
        if (_isTag(phrasePiece)) {
          if (phrasePiece == Constants.BOLD_TAG) backwardsBoldTagsCount++;
          if (phrasePiece == Constants.ITALIC_TAG) backwardsItalicTagsCount++;
          if (phrasePiece == Constants.STRIKETHROUGH_TAG) backwardsStrikethroughTagsCount++;
        }
      }

      for (String phrasePiece in phraseAfterWord) {
        if (_isTag(phrasePiece)) {
          if (phrasePiece == Constants.BOLD_TAG) forwardsBoldTagsCount++;
          if (phrasePiece == Constants.ITALIC_TAG) forwardsItalicTagsCount++;
          if (phrasePiece == Constants.STRIKETHROUGH_TAG) forwardsStrikethroughTagsCount++;
        }
      }

      final int boldTagsTotalCount = backwardsBoldTagsCount + forwardsBoldTagsCount;
      final int italicTagsTotalCount = backwardsItalicTagsCount + forwardsItalicTagsCount;
      final int strikeThroughTagsTotalCount = backwardsStrikethroughTagsCount + forwardsStrikethroughTagsCount;

      Set<TextStyleTag> wordTags = extractWordTags(
        backwardsBoldTagsCount: backwardsBoldTagsCount,
        backwardsItalicTagsCount: backwardsItalicTagsCount,
        backwardsStrikethroughTagsCount: backwardsStrikethroughTagsCount,
        forwardsBoldTagsCount: forwardsBoldTagsCount,
        forwardsItalicTagsCount: forwardsItalicTagsCount,
        forwardsStrikethroughTagsCount: forwardsStrikethroughTagsCount,
        boldTagsTotalCount: boldTagsTotalCount,
        italicTagsTotalCount: italicTagsTotalCount,
        strikeThroughTagsTotalCount: strikeThroughTagsTotalCount,
      );

      final String currentWord = brokenPhrase[index];
      final bool isTag = _isTag(currentWord);
      final bool isBoldTag = currentWord == Constants.BOLD_TAG;
      final bool isItalicTag = currentWord == Constants.ITALIC_TAG;
      final bool isStrikethroughTag = currentWord == Constants.STRIKETHROUGH_TAG;

      if (!isTag) {
        phraseWords.add(PhrasePiece(text: currentWord, tags: wordTags));
      } else {
        int tagPosition = brokenPhrase.lastIndexOf(currentWord);
        if ((isBoldTag && boldTagsTotalCount.isOdd && (tagPosition == index)) ||
            (isItalicTag && italicTagsTotalCount.isOdd && (tagPosition == index)) ||
            (isStrikethroughTag && strikeThroughTagsTotalCount.isOdd && (tagPosition == index))) {
          phraseWords.add(PhrasePiece(text: currentWord, tags: wordTags));
        }
      }

      index++;
    }

    final List<PhrasePiece> phrasePieces = [];
    if (phraseWords.length > 1) {
      phrasePieces.addAll(mergePieces(phraseWords: phraseWords));
    } else {
      phrasePieces.addAll(phraseWords);
    }

    return phrasePieces;
  }

  static List<PhrasePiece> mergePieces({@required List<PhrasePiece> phraseWords}) {
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
          if(i == phraseSublist.length - 1){
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
      String textFromPhraseWords = convertPiecesToString(phraseWords);
      String textFromPhrasePieces = convertPiecesToString(phrasePieces);

      if(textFromPhraseWords == textFromPhrasePieces) break;
    }

    return phrasePieces;
  }

  static Set<TextStyleTag> extractWordTags({
    @required int backwardsBoldTagsCount,
    @required int forwardsBoldTagsCount,
    @required int backwardsItalicTagsCount,
    @required int forwardsItalicTagsCount,
    @required int backwardsStrikethroughTagsCount,
    @required int forwardsStrikethroughTagsCount,
    @required int boldTagsTotalCount,
    @required int italicTagsTotalCount,
    @required int strikeThroughTagsTotalCount,
  }) {
    final Set<TextStyleTag> tags = {};

    if (backwardsBoldTagsCount > 0 && backwardsBoldTagsCount.isOdd && boldTagsTotalCount.isEven) {
      tags.add(TextStyleTag.BOLD);
    }
    if (backwardsItalicTagsCount > 0 && backwardsItalicTagsCount.isOdd && italicTagsTotalCount.isEven) {
      tags.add(TextStyleTag.ITALIC);
    }
    if (backwardsStrikethroughTagsCount > 0 && backwardsStrikethroughTagsCount.isOdd && strikeThroughTagsTotalCount.isEven) {
      tags.add(TextStyleTag.STRIKETHROUGH);
    }

    if (tags.isEmpty) {
      tags.add(TextStyleTag.NORMAL);
    }

    return tags;
  }

  static bool _isTag(String text) {
    return text == Constants.BOLD_TAG || text == Constants.ITALIC_TAG || text == Constants.STRIKETHROUGH_TAG;
  }

  static String convertPiecesToString(List<PhrasePiece> pieces){
    String text = '';
    for(PhrasePiece piece in pieces){
      text += piece.text;
    }
    return text;
  }

  static TextStyleTag convertStringToTextStyleTag(String tag) {
    switch (tag) {
      case Constants.BOLD_TAG:
        return TextStyleTag.BOLD;
      case Constants.ITALIC_TAG:
        return TextStyleTag.ITALIC;
      case Constants.STRIKETHROUGH_TAG:
        return TextStyleTag.STRIKETHROUGH;
      default:
        return TextStyleTag.NORMAL;
    }
  }
}
