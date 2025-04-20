import 'generator/swagger_generator.dart';

void main(List<String> arguments) async {
  String swaggerPath = 'lib/swagger.json';
  if (arguments.isNotEmpty) {
    swaggerPath = arguments[0];
  }

  await swaggerGenerator(swaggerPath);
}
