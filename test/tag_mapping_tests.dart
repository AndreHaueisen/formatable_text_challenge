import 'package:flutter_test/flutter_test.dart';
import 'package:formatable_text/constants.dart';
import 'package:formatable_text/models/phrase_piece.dart';
import 'package:formatable_text/utils.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

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
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseNormal);

    expect(parsedString[0].text, "The cow entered the prohibited zone and died a horrible death");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseBold);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.BOLD);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.BOLD);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseItalic);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold & italic", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseBoldItalic);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.BOLD);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic & bold", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseItalicBold);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.BOLD);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing strikethrough & bold", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseStrikethroughBold);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.STRIKETHROUGH);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.BOLD);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.BOLD);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 2);
    expect(parsedString[2].tags.contains(TextStyleTag.BOLD), true);
    expect(parsedString[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.BOLD);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(parsedString[0].text, "The cow ");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, "entered the");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.BOLD);

    expect(parsedString[2].text, " prohibited zone and died ");
    expect(parsedString[2].tags.length, 2);
    expect(parsedString[2].tags.contains(TextStyleTag.BOLD), true);
    expect(parsedString[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(parsedString[3].text, "a horrible");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.BOLD);

    expect(parsedString[4].text, " death");
    expect(parsedString[4].tags.length, 1);
    expect(parsedString[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test odd tag count of same tag", (){
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseOddTagCountOfSameTag);

    expect(parsedString[0].text, "The cow entered the");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, " prohibited zone and");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[2].text, " died a horrible${Constants.ITALIC_TAG} death");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);
  });

  test("test odd tag count of different tags", (){
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseOddTagCountOfDifferentTags);

    expect(parsedString[0].text, "The cow entered the");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, " prohibited zone and");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[2].text, " died a horrible${Constants.BOLD_TAG} death");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.NORMAL);
  });

  test("test with first tag hanging", (){
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseWithFirstTagHangging);

    expect(parsedString[0].text, "The cow entered the${Constants.ITALIC_TAG}");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[1].text, " prohibited zone and");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.NORMAL);

    expect(parsedString[2].text, " died a horrible");
    expect(parsedString[2].tags.length, 1);
    expect(parsedString[2].tags.first, TextStyleTag.BOLD);

    expect(parsedString[3].text, " death");
    expect(parsedString[3].tags.length, 1);
    expect(parsedString[3].tags.first, TextStyleTag.NORMAL);
  });

  test("test single tag", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseItalicSingleTag);

    expect(parsedString[0].text, "The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test starting with tag", () {
    List<PhrasePiece> parsedString = Utils.parseStringFormat(phraseStartingWithTag);

    expect(parsedString[0].text, "The cow entered the");
    expect(parsedString[0].tags.length, 1);
    expect(parsedString[0].tags.first, TextStyleTag.ITALIC);

    expect(parsedString[1].text, " prohibited zone and died a horrible death");
    expect(parsedString[1].tags.length, 1);
    expect(parsedString[1].tags.first, TextStyleTag.NORMAL);
  });

}
