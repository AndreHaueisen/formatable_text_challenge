

import 'package:flutter/foundation.dart';

import '../constants.dart';

class TagsBeforeWordCounter {

  final int boldCount;
  final int italicCount;
  final int strikethroughCount;

  TagsBeforeWordCounter({@required this.boldCount, @required this.italicCount, @required this.strikethroughCount});

  factory TagsBeforeWordCounter.fromBrokenPhrase({@required List<String> brokenPhrase, @required wordPosition}){
    int boldTagCount = 0;
    int italicTagCount = 0;
    int strikethroughTagCount = 0;

    final List<String> phraseBeforeWord = brokenPhrase.getRange(0, wordPosition).toList(growable: false);

    for (String phrasePiece in phraseBeforeWord) {
      if (_isTag(phrasePiece)) {
        if (phrasePiece == Constants.BOLD_TAG) boldTagCount++;
        if (phrasePiece == Constants.ITALIC_TAG) italicTagCount++;
        if (phrasePiece == Constants.STRIKETHROUGH_TAG) strikethroughTagCount++;
      }
    }

    return TagsBeforeWordCounter(boldCount: boldTagCount, italicCount: italicTagCount, strikethroughCount: strikethroughTagCount);
  }


  static bool _isTag(String text) {
    return text == Constants.BOLD_TAG || text == Constants.ITALIC_TAG || text == Constants.STRIKETHROUGH_TAG;
  }

}