import 'package:flutter_test/flutter_test.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/merged_phrase_pieces.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/utils.dart';
import 'package:formatable_text/widgets/formattable_text.dart';

main() {

  String phraseNormal;
  String phraseBold;
  String phraseItalic;
  String phraseBoldItalic;
  String phraseItalicBold;
  String phraseStrikethroughBold;
  String phraseItalicInsideBold;
  String phraseItalicSingleTag;
  String phraseOddTagCountOfSameTag;
  String phraseOddTagCountOfDifferentTags;
  String phraseWithFirstTagHangging;
  String phraseStartingWithTag;

  setUp(() {

    phraseNormal = "The cow entered the prohibited zone and died a horrible death";
    phraseBold = "The cow ${Constants.BOLD_TAG}entered the${Constants.BOLD_TAG} prohibited zone and died ${Constants.BOLD_TAG}a horrible${Constants.BOLD_TAG} death";
    phraseItalic ="The cow ${Constants.ITALIC_TAG}entered the${Constants.ITALIC_TAG} prohibited zone and died ${Constants.ITALIC_TAG}a horrible${Constants.ITALIC_TAG} death";
    phraseBoldItalic = "The cow ${Constants.BOLD_TAG}entered the${Constants.BOLD_TAG} prohibited zone and died ${Constants.ITALIC_TAG}a horrible${Constants.ITALIC_TAG} death";
    phraseItalicBold =  "The cow ${Constants.ITALIC_TAG}entered the${Constants.ITALIC_TAG} prohibited zone and died ${Constants.BOLD_TAG}a horrible${Constants.BOLD_TAG} death";
    phraseStrikethroughBold =  "The cow ${Constants.STRIKETHROUGH_TAG}entered the${Constants.STRIKETHROUGH_TAG} prohibited zone and died ${Constants.BOLD_TAG}a horrible${Constants.BOLD_TAG} death";
    phraseItalicInsideBold = "The cow ${Constants.BOLD_TAG}entered the${Constants.ITALIC_TAG} prohibited zone and died ${Constants.ITALIC_TAG}a horrible${Constants.BOLD_TAG} death";
    phraseItalicSingleTag = "The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death";
    phraseOddTagCountOfSameTag = "The cow entered the${Constants.ITALIC_TAG} prohibited zone and${Constants.ITALIC_TAG} died a horrible${Constants.ITALIC_TAG} death";
    phraseOddTagCountOfDifferentTags = "The cow entered the${Constants.ITALIC_TAG} prohibited zone and${Constants.ITALIC_TAG} died a horrible${Constants.BOLD_TAG} death";
    phraseWithFirstTagHangging = "The cow entered the${Constants.ITALIC_TAG} prohibited zone and${Constants.BOLD_TAG} died a horrible${Constants.BOLD_TAG} death";
    phraseStartingWithTag = "${Constants.ITALIC_TAG}The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death";
  });

  test("test phrase format parsing normal", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseNormal);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the prohibited zone and died a horrible death");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseBold);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseItalic);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold & italic", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseBoldItalic);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic & bold", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseItalicBold);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing strikethrough & bold", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseStrikethroughBold);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.STRIKETHROUGH);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 2);
    expect(phrasePieces.mergedPhrasePieces[2].tags.contains(TextStyleTag.BOLD), true);
    expect(phrasePieces.mergedPhrasePieces[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow ");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, "entered the");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[2].text, " prohibited zone and died ");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 2);
    expect(phrasePieces.mergedPhrasePieces[2].tags.contains(TextStyleTag.BOLD), true);
    expect(phrasePieces.mergedPhrasePieces[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(phrasePieces.mergedPhrasePieces[3].text, "a horrible");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[4].text, " death");
    expect(phrasePieces.mergedPhrasePieces[4].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test odd tag count of same tag", (){
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseOddTagCountOfSameTag);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, " prohibited zone and");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[2].text, " died a horrible${Constants.ITALIC_TAG} death");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);
  });

  test("test odd tag count of different tags", (){
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseOddTagCountOfDifferentTags);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, " prohibited zone and");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[2].text, " died a horrible${Constants.BOLD_TAG} death");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.NORMAL);
  });

  test("test with first tag hanging", (){
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseWithFirstTagHangging);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the${Constants.ITALIC_TAG}");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[1].text, " prohibited zone and");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.NORMAL);

    expect(phrasePieces.mergedPhrasePieces[2].text, " died a horrible");
    expect(phrasePieces.mergedPhrasePieces[2].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[2].tags.first, TextStyleTag.BOLD);

    expect(phrasePieces.mergedPhrasePieces[3].text, " death");
    expect(phrasePieces.mergedPhrasePieces[3].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[3].tags.first, TextStyleTag.NORMAL);
  });

  test("test single tag", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseItalicSingleTag);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test starting with tag", () {
    MergedPhrasePieces phrasePieces = Utils.parseStringFormat(phraseStartingWithTag);

    expect(phrasePieces.mergedPhrasePieces[0].text, "The cow entered the");
    expect(phrasePieces.mergedPhrasePieces[0].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[0].tags.first, TextStyleTag.ITALIC);

    expect(phrasePieces.mergedPhrasePieces[1].text, " prohibited zone and died a horrible death");
    expect(phrasePieces.mergedPhrasePieces[1].tags.length, 1);
    expect(phrasePieces.mergedPhrasePieces[1].tags.first, TextStyleTag.NORMAL);
  });

}
