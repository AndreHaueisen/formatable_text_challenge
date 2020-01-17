
class Constants {
  const Constants();

  static const String ITALIC_TAG = '_';
  static const String BOLD_TAG = '@';
  static const String STRIKETHROUGH_TAG = '~';

  static const String SPLIT_PATTERN =
      "(?<=${Constants.BOLD_TAG})|(?=${Constants.BOLD_TAG})|(?<=${Constants.ITALIC_TAG})|(?=${Constants.ITALIC_TAG})|(?<=${Constants.STRIKETHROUGH_TAG})|(?=${Constants.STRIKETHROUGH_TAG})";

}