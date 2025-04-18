// Blue text
import 'dart:io';

void printB(Object? msg) {
  print('\x1B[34m$msg\x1B[0m');
}

// Green text
void printG(Object? msg) {
  print('\x1B[32m$msg\x1B[0m');
}

// Yellow text
void printY(Object? msg) {
  print('\x1B[33m$msg\x1B[0m');
}

// Red text
void printR(Object? msg) {
  print('\x1B[31m$msg\x1B[0m');
}

// white text
void printW(Object? msg) {
  print('\x1B[37m$msg\x1B[0m');
}

// cyan text
void printC(Object? msg) {
  print('\x1B[36m$msg\x1B[0m');
}

// black text
void printK(Object? msg) {
  print('\x1B[30m$msg\x1B[0m');
}

// orange text
void printO(Object? msg) {
  print('\x1B[38;5;208m$msg\x1B[0m');
}

// purple text
void printP(Object? msg) {
  print('\x1B[35m$msg\x1B[0m');
}

// brown text
void printBrown(Object? msg) {
  print('\x1B[38;5;130m$msg\x1B[0m');
}

// ANSI color codes
const String _reset = '\x1B[0m';
const String _red = '\x1B[31m';
const String _green = '\x1B[32m';
const String _yellow = '\x1B[33m';
const String _blue = '\x1B[34m';
const String _cyan = '\x1B[36m';
void printSuccess(String message) => print('$_green$message$_reset');
void printError(String message) => print('$_red$message$_reset');
void printWarning(String message) => print('$_yellow$message$_reset');
void printInfo(String message) => print('$_blue$message$_reset');
void printProgress(String message) => stdout.write('$_cyan$message$_reset');

/// Prompts the user for input and returns their response
String promptUser(String question) {
  stdout.write('$_yellow$question (y/n): $_reset');
  return stdin.readLineSync()?.toLowerCase() ?? 'n';
}
