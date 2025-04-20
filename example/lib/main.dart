import 'package:flutter_easy_swagger_generator/generator/swagger_generator.dart';

void main(List<String> arguments, isEx) async {
  String source = 'example/swagger.json';
  if (arguments.isNotEmpty) {
    source = arguments[0];
  }
  await swaggerGenerator(source, isExample: true);
}
