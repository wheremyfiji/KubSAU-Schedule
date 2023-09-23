extension StringExt on String {
  String capitalizeFirstTwoChars() {
    if (length < 2) {
      return this;
    }

    String firstTwoChars = substring(0, 2).toUpperCase();
    String restOfString = substring(2);
    String result = firstTwoChars + restOfString;

    return result;
  }
}
