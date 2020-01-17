import 'package:flutter/foundation.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_data.dart';
import 'package:formatable_text/models/tag.dart';
import 'package:formatable_text/models/tags_before_word_counter.dart';
import 'package:formatable_text/widgets/formattable_text.dart';

class PhrasePiece {
  final String text;
  final Set<TextStyleTag> tags;

  PhrasePiece({
    @required this.text,
    @required this.tags,
  });

  PhrasePiece copy({String text, Set<TextStyleTag> tags}) {
    return PhrasePiece(text: text ?? this.text, tags: tags ?? this.tags);
  }

  static PhrasePiece intoTagOrPiece({
    @required String text,
    @required PhraseData phraseData,
    @required int textPositionInPhrase,
    @required TagsBeforeWordCounter tagsBeforeWordCounter,
  }) {
    if (_isTag(text)) {
      return Tag.fromPhraseData(
        text: text,
        textPositionInPhrase: textPositionInPhrase,
        phraseData: phraseData,
        tagsBeforeWordCounter: tagsBeforeWordCounter,
      );
    } else {
      return PhrasePiece.fromPhraseData(
        text: text,
        textPositionInPhrase: textPositionInPhrase,
        phraseData: phraseData,
        tagsBeforeWordCounter: tagsBeforeWordCounter,
      );
    }
  }

  static bool _isTag(String text) {
    return text == Constants.BOLD_TAG || text == Constants.ITALIC_TAG || text == Constants.STRIKETHROUGH_TAG;
  }

  factory PhrasePiece.fromPhraseData({
    @required String text,
    @required PhraseData phraseData,
    @required int textPositionInPhrase,
    @required TagsBeforeWordCounter tagsBeforeWordCounter,
  }) {
    Set<TextStyleTag> tags = {};
    tags.addAll(
      _extractWordTags(
        tagsBeforeWordCounter: tagsBeforeWordCounter,
        phraseData: phraseData,
        position: textPositionInPhrase,
      ),
    );

    return PhrasePiece(
      text: text,
      tags: tags,
    );
  }

  static Set<TextStyleTag> _extractWordTags({
    @required TagsBeforeWordCounter tagsBeforeWordCounter,
    @required PhraseData phraseData,
    @required int position,
  }) {
    final Set<TextStyleTag> tags = {};

    if (tagsBeforeWordCounter.boldCount > 0 && tagsBeforeWordCounter.boldCount.isOdd && position < phraseData.lastBoldTagPosition) {
      tags.add(TextStyleTag.BOLD);
    }
    if (tagsBeforeWordCounter.italicCount > 0 && tagsBeforeWordCounter.italicCount.isOdd && position < phraseData.lastItalicTagPosition) {
      tags.add(TextStyleTag.ITALIC);
    }
    if (tagsBeforeWordCounter.strikethroughCount > 0 &&
        tagsBeforeWordCounter.strikethroughCount.isOdd &&
        position < phraseData.lastStrikeThroughTagPosition) {
      tags.add(TextStyleTag.STRIKETHROUGH);
    }

    if (tags.isEmpty) {
      tags.add(TextStyleTag.NORMAL);
    }

    return tags;
  }
}
