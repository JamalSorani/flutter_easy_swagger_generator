import 'dart:io';

/// ANSI color codes
const String _reset = '\x1B[0m';
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

/// Printer class for colored console output
/// Print with color
void _print(Object? message, String color) {
  print('$color$message$_reset');
}

/// Print to stdout with color (no newline)
void _write(Object? message, String color) {
  stdout.write('$color$message$_reset');
}

// Standard print functions
void printBlack(Object? msg) => _print(msg, _black);
void printYellow(Object? msg) => _print(msg, _yellow);
void printPurple(Object? msg) => _print(msg, _purple);
void printWhite(Object? msg) => _print(msg, _white);
void printBrown(Object? msg) => _print(msg, _brown);

// Semantic print functions
void printSuccess(String message) => _print(message, _green);
void printError(String message) => _print(message, _red);
void printWarning(String message) => _print(message, _orange);
void printInfo(String message) => _print(message, _blue);
void printProgress(String message) => _write(message, _cyan);

/// Prompts the user for input and returns their response
String promptUser(String question) {
  stdout.write('$_orange$question (y/n): $_reset');
  return stdin.readLineSync()?.toLowerCase() ?? 'n';
}
