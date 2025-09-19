import 'dart:io';

/// ANSI color reset code.
const String _reset = '\x1B[0m';

/// ANSI color codes for various text colors.
const String _black = '\x1B[30m';
const String _red = '\x1B[31m';
const String _green = '\x1B[32m';
const String _yellow = '\x1B[33m';
const String _blue = '\x1B[34m';
const String _purple = '\x1B[35m';
const String _cyan = '\x1B[36m';
const String _white = '\x1B[37m';
const String _orange = '\x1B[38;5;208m';
const String _brown = '\x1B[38;5;130m';

/// Prints a [message] with the given [color] and appends a newline.
///
/// Resets the terminal color afterward.
void _print(Object? message, String color) {
  print('$color$message$_reset');
}

/// Writes a [message] with the given [color] without appending a newline.
///
/// Resets the terminal color afterward.
void _write(Object? message, String color) {
  stdout.write('$color$message$_reset');
}

/// Prints a message in **black**.
void printBlack(Object? msg) => _print(msg, _black);

/// Prints a message in **yellow**.
void printYellow(Object? msg) => _print(msg, _yellow);

/// Prints a message in **purple**.
void printPurple(Object? msg) => _print(msg, _purple);

/// Prints a message in **white**.
void printWhite(Object? msg) => _print(msg, _white);

/// Prints a message in **brown**.
void printBrown(Object? msg) => _print(msg, _brown);

/// Prints a **success message** in green.
void printSuccess(String message) => _print(message, _green);

/// Prints an **error message** in red.
void printError(String message) => _print(message, _red);

void printDebug(dynamic message) => _print(message.toString(), _orange);

/// Prints a **warning message** in orange.
void printWarning(String message) => _print(message, _orange);

/// Prints an **info message** in blue.
void printInfo(String message) => _print(message, _blue);

/// Prints a **progress message** in cyan (without newline).
void printProgress(String message) => _write(message, _cyan);

/// Prompts the user with a [question] in orange and waits for input.
///
/// Returns:
/// - `'y'` if the user responds with yes.
/// - `'n'` if the user responds with no or gives no input.
///
/// Example:
/// ```dart
/// final answer = promptUser("Do you want to continue?");
/// if (answer == 'y') {
///   printSuccess("Continuing...");
/// }
/// ```
String promptUser(String question) {
  stdout.write('$_orange$question (y/n): $_reset');
  return stdin.readLineSync()?.toLowerCase() ?? 'n';
}

void printMap(String title, Map<String, dynamic> map) {
  //TODO change colors
  print(title);
  map.forEach((key, value) {
    print("$key: $value");
  });
}

String makeBanner(String text, {int totalLength = 80}) {
  // Start with the base: //! <text>
  final base = '//! $text ';
  // How many "=" are needed to reach totalLength?
  final remaining = totalLength - base.length;
  final dashes = remaining > 0 ? '=' * remaining : '';
  return '$base$dashes';
}
