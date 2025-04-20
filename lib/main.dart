import 'generator/swagger_generator.dart';

/// Entry point for the application
void main(List<String> arguments) async {
  await swaggerGenerator(arguments[0]);
}
