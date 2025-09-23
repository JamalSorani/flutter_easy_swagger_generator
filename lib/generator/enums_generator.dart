import 'dart:io';

import '../helpers/imports.dart';

class EnumsGenerator {
  final Components components;

  final String mainPath;

  EnumsGenerator({
    required this.components,
    required this.mainPath,
  });

  String generateEnums() {
    final classBuffer = StringBuffer();
    components.schemas.forEach(
      (key, value) {
        bool isEnum = key.contains(".Enum");
        String enumName = key.split(".").last;
        final enumValues = value.enumValues;
        if (isEnum) {
          classBuffer.writeln("enum ${enumName}GlobalEnum {");
          for (var enumValue in enumValues) {
            classBuffer.writeln("  $enumValue,");
          }
          classBuffer.writeln("}");
        }
      },
    );

    final file = File("$mainPath/enums.dart");
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(classBuffer.toString());
    return classBuffer.toString();
  }
}
