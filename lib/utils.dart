import 'package:flutter/material.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

class Utils {
  static List<PhrasePiece> parseStringFormat(String text) {
    List<PhrasePiece> phrasePieces = [];

    final String pattern =
        "(?<=${Constants.BOLD_TAG})|(?=${Constants.BOLD_TAG})|(?<=${Constants.ITALIC_TAG})|(?=${Constants.ITALIC_TAG})|(?<=${Constants.STRIKETHROUGH_TAG})|(?=${Constants.STRIKETHROUGH_TAG})";

    final List<String> brokenPhrase = text.split(RegExp(pattern));
    final List<int> boldPositions = getCharacterPositions(brokenPhrase, Constants.BOLD_TAG);
    final List<int> italicPositions = getCharacterPositions(brokenPhrase, Constants.ITALIC_TAG);
    final List<int> strikeThroughPositions = getCharacterPositions(brokenPhrase, Constants.STRIKETHROUGH_TAG);

    phrasePieces.addAll(generatePiecesFromPositions(
      boldPositions: boldPositions,
      italicPositions: italicPositions,
      strikeThroughPositions: strikeThroughPositions,
      brokenPhrase: brokenPhrase,
    ));

    phrasePieces.addAll(generateNormalTextPieces(
      brokenPhrase: brokenPhrase,
      phrasePieces: phrasePieces,
    ));

    phrasePieces.sort((current, next) => current.positions.first.compareTo(next.positions.first));

    return phrasePieces;
  }

  static List<int> getCharacterPositions(List<String> brokenPhrase, String char) {
    final List<int> characterPositions = [];
    for (int index = 0; index < brokenPhrase.length; index++) {
      String word = brokenPhrase[index];
      if (word == char) {
        characterPositions.add(index);
      }
    }

    return characterPositions;
  }

  static List<PhrasePiece> generatePiecesFromPositions({
    @required List<int> boldPositions,
    @required List<int> italicPositions,
    @required List<int> strikeThroughPositions,
    @required List<String> brokenPhrase,
  }) {
    final List<PhrasePiece> phrasePieces = [];
    final mergedPositions = [];
    mergedPositions.addAll(boldPositions);
    mergedPositions.addAll(italicPositions);
    mergedPositions.addAll(strikeThroughPositions);
    mergedPositions.sort();

    int boldIndex = 0;
    int italicIndex = 0;
    int strikethroughIndex = 0;

    for (int i = 0; i < mergedPositions.length; i = i + 2) {
      final Set<TextStyleTag> styleTags = {};
      if (boldPositions.contains(mergedPositions[i])) {
        styleTags.add(TextStyleTag.BOLD);
        int currentBoldPosition = boldPositions[boldIndex];
        int nextBoldPosition = boldPositions[boldIndex + 1];

        TextStyleTag italicTag = getStyleTagIfInBetween(currentBoldPosition, nextBoldPosition, italicPositions, TextStyleTag.ITALIC);
        if (italicTag != null) {
          styleTags.add(italicTag);
        }

        TextStyleTag strikethroughTag =
            getStyleTagIfInBetween(currentBoldPosition, nextBoldPosition, strikeThroughPositions, TextStyleTag.STRIKETHROUGH);
        if (strikethroughTag != null) {
          styleTags.add(strikethroughTag);
        }

        boldIndex++;
      } else if (italicPositions.contains(mergedPositions[i])) {
        styleTags.add(TextStyleTag.ITALIC);

        int currentItalicPosition = italicPositions[italicIndex];
        int nextItalicPosition = italicPositions[italicIndex + 1];

        TextStyleTag boldTag = getStyleTagIfInBetween(currentItalicPosition, nextItalicPosition, boldPositions, TextStyleTag.BOLD);
        if (boldTag != null) {
          styleTags.add(boldTag);
        }

        TextStyleTag strikethroughTag =
            getStyleTagIfInBetween(currentItalicPosition, nextItalicPosition, strikeThroughPositions, TextStyleTag.STRIKETHROUGH);
        if (strikethroughTag != null) {
          styleTags.add(strikethroughTag);
        }

        italicIndex++;
      } else if (strikeThroughPositions.contains(mergedPositions[i])) {
        styleTags.add(TextStyleTag.STRIKETHROUGH);

        int currentStrikethroughPosition = strikeThroughPositions[strikethroughIndex];
        int nextStrikethroughPosition = strikeThroughPositions[strikethroughIndex + 1];

        TextStyleTag boldTag =
            getStyleTagIfInBetween(currentStrikethroughPosition, nextStrikethroughPosition, boldPositions, TextStyleTag.BOLD);
        if (boldTag != null) {
          styleTags.add(boldTag);
        }

        TextStyleTag italicTag =
            getStyleTagIfInBetween(currentStrikethroughPosition, nextStrikethroughPosition, italicPositions, TextStyleTag.ITALIC);
        if (italicTag != null) {
          styleTags.add(italicTag);
        }

        strikethroughIndex++;
      }

      final int startIndex = mergedPositions[i];
      final int endIndex = mergedPositions[i + 1];

      final List<int> positionsInBetween = [];
      for (int i = startIndex; i <= endIndex; i++) {
        positionsInBetween.add(i);
      }

      final PhrasePiece piece = PhrasePiece.fromBrokenPhrase(positions: positionsInBetween, tags: styleTags, brokenPhrase: brokenPhrase);
      phrasePieces.add(piece);
    }

    return phrasePieces;
  }

  static TextStyleTag getStyleTagIfInBetween(int currentPosition, int nextPosition, List<int> positions, TextStyleTag tag) {
    for (int index = 0; index < positions.length; index = index + 2) {
      if ((currentPosition > positions[index]) && (nextPosition < positions[index + 1])) {
        return tag;
      }
    }

    return null;
  }

  static List<PhrasePiece> generateNormalTextPieces({
    @required List<String> brokenPhrase,
    @required List<PhrasePiece> phrasePieces,
  }) {
    final List<int> allPositions = List.generate(brokenPhrase.length, (index) => index);
    final Set<int> allOccupiedPositions = {};
    final Set<int> allFreePositions = {};

    for (PhrasePiece phrasePiece in phrasePieces) {
      allOccupiedPositions.addAll(phrasePiece.positions);
    }

    allPositions.forEach((element) {
      if (!allOccupiedPositions.contains(element)) {
        allFreePositions.add(element);
      }
    });

    return generatePiecesFromNormalPositions(
      styleTag: TextStyleTag.NORMAL,
      positions: allFreePositions.toList(growable: false),
      brokenPhrase: brokenPhrase,
    );
  }

  static List<PhrasePiece> generatePiecesFromNormalPositions({
    @required TextStyleTag styleTag,
    @required List<int> positions,
    @required List<String> brokenPhrase,
  }) {
    final List<PhrasePiece> phrasePieces = [];

    int index = 0;
    while (index < positions.length) {
      PhrasePiece piece = PhrasePiece.fromBrokenPhrase(positions: [positions[index]], tags: {styleTag}, brokenPhrase: brokenPhrase);
      phrasePieces.add(piece);
      index++;
    }

    return phrasePieces;
  }

  static void _trimTagPositionsList(List<int> tagPositions) {
    if (tagPositions.length.isOdd) {
      tagPositions.removeLast();
    }
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
