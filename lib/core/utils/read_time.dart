int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  // speed = distance / time;
  // taking average = 238 words per minute

  final readingTime = wordCount / 238;

  return readingTime.ceil();
}
