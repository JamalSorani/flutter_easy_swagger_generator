String toCamelCase(String text) {
  if (text.isEmpty) return text;

  // Split by any non-alphanumeric character
  final words = text.split(RegExp(r'[^a-zA-Z0-9]'));

  // Convert first word to lowercase
  final firstWord = words[0].toLowerCase();

  // Convert remaining words to title case
  final remainingWords = words.skip(1).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join('');

  return firstWord + remainingWords;
}
