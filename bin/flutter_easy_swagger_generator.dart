import 'package:flutter_easy_swagger_generator/flutter_easy_swagger_generator.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Missing Swagger file path.');
    print('Usage: dart run flutter_easy_swagger_generator <path_to_swagger.json> [--watch]');
    return;
  }

  final swaggerPath = args.first;

  await swaggerGenerator(swaggerPath);


}
