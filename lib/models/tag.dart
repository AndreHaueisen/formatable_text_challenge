import 'package:flutter/foundation.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_data.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/models/tags_before_word_counter.dart';

class Tag extends PhrasePiece {
  final bool isBoldTag;
  final bool isItalicTag;
  final bool isStrikethroughTag;
  final bool isLastBoldTag;
  final bool isLastItalicTag;
  final bool isLastStrikethroughTag;

  Tag({
    @required String text,
    @required this.isBoldTag,
    @required this.isItalicTag,
    @required this.isStrikethroughTag,
    @required this.isLastBoldTag,
    @required this.isLastItalicTag,
    @required this.isLastStrikethroughTag,
  }) : super(text: text, tags: {});

  factory Tag.fromPhraseData({
    @required String text,
    @required textPositionInPhrase,
    @required PhraseData phraseData,
    @required TagsBeforeWordCounter tagsBeforeWordCounter,
  }) {
    final bool isBoldTag = text == Constants.BOLD_TAG;
    final bool isItalicTag = text == Constants.ITALIC_TAG;
    final bool isStrikethroughTag = text == Constants.STRIKETHROUGH_TAG;

    final bool isLastBoldTag =
        (isBoldTag && phraseData.boldTagsTotalCount.isOdd && (phraseData.lastBoldTagPosition == textPositionInPhrase));
    final bool isLastItalicTag =
        (isItalicTag && phraseData.italicTagsTotalCount.isOdd && (phraseData.lastItalicTagPosition == textPositionInPhrase));
    final bool isLastStrikethroughTag = (isStrikethroughTag &&
        phraseData.strikeThroughTagsTotalCount.isOdd &&
        (phraseData.lastStrikeThroughTagPosition == textPositionInPhrase));

    return Tag(
      text: text,
      isBoldTag: isBoldTag,
      isItalicTag: isItalicTag,
      isStrikethroughTag: isStrikethroughTag,
      isLastBoldTag: isLastBoldTag,
      isLastItalicTag: isLastItalicTag,
      isLastStrikethroughTag: isLastStrikethroughTag,
    );
  }
}
