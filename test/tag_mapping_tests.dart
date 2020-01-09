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
    phraseStartingWithTag = "${Constants.ITALIC_TAG}The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death";
  });

  test("test phrase format parsing normal", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseNormal);

    expect(formatMapList[0].text, "The cow entered the prohibited zone and died a horrible death");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseBold);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 1);
    expect(formatMapList[2].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseItalic);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.ITALIC);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 1);
    expect(formatMapList[2].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.ITALIC);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing bold & italic", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseBoldItalic);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 1);
    expect(formatMapList[2].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.ITALIC);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic & bold", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseItalicBold);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.ITALIC);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 1);
    expect(formatMapList[2].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing strikethrough & bold", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseStrikethroughBold);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.STRIKETHROUGH);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 1);
    expect(formatMapList[2].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 2);
    expect(formatMapList[2].tags.contains(TextStyleTag.BOLD), true);
    expect(formatMapList[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test phrase format parsing italic inside bold", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseItalicInsideBold);

    expect(formatMapList[0].text, "The cow ");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);

    expect(formatMapList[1].text, "entered the");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[2].text, " prohibited zone and died ");
    expect(formatMapList[2].tags.length, 2);
    expect(formatMapList[2].tags.contains(TextStyleTag.BOLD), true);
    expect(formatMapList[2].tags.contains(TextStyleTag.ITALIC), true);

    expect(formatMapList[3].text, "a horrible");
    expect(formatMapList[3].tags.length, 1);
    expect(formatMapList[3].tags.first, TextStyleTag.BOLD);

    expect(formatMapList[4].text, " death");
    expect(formatMapList[4].tags.length, 1);
    expect(formatMapList[4].tags.first, TextStyleTag.NORMAL);
  });

  test("test single tag", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseItalicSingleTag);

    expect(formatMapList[0].text, "The cow entered the${Constants.ITALIC_TAG} prohibited zone and died a horrible death");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.NORMAL);
  });

  test("test starting with tag", () {
    List<PhrasePiece> formatMapList = Utils.parseStringFormat(phraseStartingWithTag);

    expect(formatMapList[0].text, "The cow entered the");
    expect(formatMapList[0].tags.length, 1);
    expect(formatMapList[0].tags.first, TextStyleTag.ITALIC);

    expect(formatMapList[1].text, " prohibited zone and died a horrible death");
    expect(formatMapList[1].tags.length, 1);
    expect(formatMapList[1].tags.first, TextStyleTag.NORMAL);
  });

}
