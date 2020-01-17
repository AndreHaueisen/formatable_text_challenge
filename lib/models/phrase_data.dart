import 'package:flutter/foundation.dart';

import '../constants.dart';

class PhraseData {
  final int boldTagsTotalCount;
  final int lastBoldTagPosition;
  final int italicTagsTotalCount;
  final int lastItalicTagPosition;
  final int strikeThroughTagsTotalCount;
  final int lastStrikeThroughTagPosition;
  final int totalTagCount;

  PhraseData({
    @required this.boldTagsTotalCount,
    @required this.lastBoldTagPosition,
    @required this.italicTagsTotalCount,
    @required this.lastItalicTagPosition,
    @required this.strikeThroughTagsTotalCount,
    @required this.lastStrikeThroughTagPosition,
    @required this.totalTagCount,
  });

  factory PhraseData.fromOriginalPhrase(String originalPhrase) {
    final List<String> brokenPhrase = originalPhrase.split(RegExp(Constants.SPLIT_PATTERN));

    final int lastBoldTagPosition = brokenPhrase.lastIndexOf(Constants.BOLD_TAG);
    final int lastItalicTagPosition = brokenPhrase.lastIndexOf(Constants.ITALIC_TAG);
    final int lastStrikeThroughTagPosition = brokenPhrase.lastIndexOf(Constants.STRIKETHROUGH_TAG);

    final int boldTagsTotalCount = Constants.BOLD_TAG.allMatches(originalPhrase).length;
    final int italicTagsTotalCount = Constants.ITALIC_TAG.allMatches(originalPhrase).length;
    final int strikeThroughTagsTotalCount = Constants.STRIKETHROUGH_TAG.allMatches(originalPhrase).length;
    final int totalTagCount = boldTagsTotalCount + italicTagsTotalCount + strikeThroughTagsTotalCount;

    return PhraseData(
      boldTagsTotalCount: boldTagsTotalCount,
      lastBoldTagPosition: lastBoldTagPosition,
      italicTagsTotalCount: italicTagsTotalCount,
      lastItalicTagPosition: lastItalicTagPosition,
      strikeThroughTagsTotalCount: strikeThroughTagsTotalCount,
      lastStrikeThroughTagPosition: lastStrikeThroughTagPosition,
      totalTagCount: totalTagCount,
    );
  }
}
