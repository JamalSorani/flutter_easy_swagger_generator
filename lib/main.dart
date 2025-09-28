library flutter_easy_swagger_generator;

import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

import 'flutter_easy_swagger_generator.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    printWarning('Usage: dart run main.dart [path_to_swagger.json]');
    return;
  }
  await swaggerGenerator(arguments[0],);
  // await swaggerGenerator(arguments[0], prefixesToRemove: ['Mobile']);

  //  await swaggerSingleCategoryGenerator(
  //   arguments[0],
  //   'Supplier',
  //   prefixesToRemove: ['Dashboard'],
  // );
}
// dart run lib/main.dart lib/swagger.json
