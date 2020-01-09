import 'package:flutter/material.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

class Utils {
  static List<PhrasePiece> parseStringFormat(String text) {


    final String pattern =
        "(?<=${Constants.BOLD_TAG})|(?=${Constants.BOLD_TAG})|(?<=${Constants.ITALIC_TAG})|(?=${Constants.ITALIC_TAG})|(?<=${Constants.STRIKETHROUGH_TAG})|(?=${Constants.STRIKETHROUGH_TAG})";

    final List<String> brokenPhrase = text.split(RegExp(pattern));
    List<PhrasePiece> phrasePieces = generatePiecesFromBrokenPhrase(brokenPhrase);

    return phrasePieces;
  }

  static List<PhrasePiece> generatePiecesFromBrokenPhrase(List<String> brokenPhrase){
    final List<PhrasePiece> phraseWords = [];
    int index = 0;

    while (index < brokenPhrase.length) {
      Set<TextStyleTag> wordTags = extractTagsWordTags(brokenPhrase, index);

      print('current word: ${brokenPhrase[index]}');
      if(!_isTag(brokenPhrase[index])) {
        phraseWords.add(PhrasePiece(text: brokenPhrase[index], tags: wordTags));
      }

      index++;
    }

    final List<PhrasePiece> phrasePieces = [];
    if(phraseWords.length > 1) {
      phrasePieces.addAll(mergePieces(phraseWords: phraseWords));
    } else {
      phrasePieces.addAll(phraseWords);
    }

    return phrasePieces;
  }

  static List<PhrasePiece> mergePieces({@required List<PhrasePiece> phraseWords}){

    final List<PhrasePiece> phrasePieces = [];
    int index = 0;

    while (index < phraseWords.length) {
      PhrasePiece mergedPhrasePiece;
      PhrasePiece currentPhraseWord = phraseWords[index];

      for (PhrasePiece phraseWord in phraseWords) {
        if (currentPhraseWord == phraseWord) {
          continue;
        }

        if (currentPhraseWord.tags == phraseWord.tags) {
          mergedPhrasePiece = currentPhraseWord.copy(text: currentPhraseWord.text + phraseWord.text);
          index++;
        } else {
          index++;
          break;
        }
      }

      if (mergedPhrasePiece == null) {
        mergedPhrasePiece = currentPhraseWord;
      }

      phrasePieces.add(mergedPhrasePiece);
    }

    return phrasePieces;
  }

  static Set<TextStyleTag> extractTagsWordTags(List<String> phrase, int wordIndex){
    final Set<TextStyleTag> tags = {};

    int backwardsBoldTagsCount = 0;
    int backwardsItalicTagsCount = 0;
    int backwardsStrikethroughTagsCount = 0;

    int forwardsBoldTagsCount = 0;
    int forwardsItalicTagsCount = 0;
    int forwardsStrikethroughTagsCount = 0;

    List<String> phraseBeforeWord = phrase.getRange(0, wordIndex).toList(growable: false);
    List<String> phraseAfterWord = phrase.getRange(wordIndex + 1, phrase.length).toList(growable: false);

    for(String phrasePiece in phraseBeforeWord){
      if(_isTag(phrasePiece)){
        if(phrasePiece == Constants.BOLD_TAG) backwardsBoldTagsCount++;
        if(phrasePiece == Constants.ITALIC_TAG) backwardsItalicTagsCount++;
        if(phrasePiece == Constants.STRIKETHROUGH_TAG) backwardsStrikethroughTagsCount++;
      }
    }

    for(String phrasePiece in phraseAfterWord){
      if(_isTag(phrasePiece)){
        if(phrasePiece == Constants.BOLD_TAG) forwardsBoldTagsCount++;
        if(phrasePiece == Constants.ITALIC_TAG) forwardsItalicTagsCount++;
        if(phrasePiece == Constants.STRIKETHROUGH_TAG) forwardsStrikethroughTagsCount++;
      }
    }

    final int boldTagsTotalCount = backwardsBoldTagsCount + forwardsBoldTagsCount;
    final int italicTagsTotalCount = backwardsItalicTagsCount + forwardsItalicTagsCount;
    final int strikeThroughTagsTotalCount = backwardsStrikethroughTagsCount + forwardsStrikethroughTagsCount;

    if(backwardsBoldTagsCount > 0 && backwardsBoldTagsCount.isOdd && boldTagsTotalCount.isEven){
      tags.add(TextStyleTag.BOLD);
    }
    if(backwardsItalicTagsCount > 0 && backwardsItalicTagsCount.isOdd && italicTagsTotalCount.isEven){
      tags.add(TextStyleTag.ITALIC);
    }
    if(backwardsStrikethroughTagsCount > 0 && backwardsStrikethroughTagsCount.isOdd && strikeThroughTagsTotalCount.isEven){
      tags.add(TextStyleTag.STRIKETHROUGH);
    }

    if(tags.isEmpty){
      tags.add(TextStyleTag.NORMAL);
    }

    return tags;
}

  static bool _isTag(String text){
    return text == Constants.BOLD_TAG || text == Constants.ITALIC_TAG || text == Constants.STRIKETHROUGH_TAG;
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
