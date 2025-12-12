import 'package:flutter_easy_swagger_generator/generator/class_content_generator/entities/parametars_generator.dart';

class CopyWithGenerator {
  static String generateCopyWith({
    required String className,
    required List<GeneratedParameters> params,
  }) {
    final buffer = StringBuffer();
    bool isEmpty = params.isEmpty;
    if (isEmpty) {
      return '';
    }

    // Start method
    buffer.writeln('  $className copyWith({');
    // Parameters: type? name,
    for (var p in params) {
      bool isDynamicType = p.type.toLowerCase() == 'dynamic';

      final fieldName = p.generatedConstructorVariable
          .replaceAll('required ', '')
          .replaceAll('this.', '')
          .replaceAll(',', '')
          .trim();
      buffer.writeln('    ${p.type}${isDynamicType ? "" : "?"} $fieldName,');
    }

    buffer.writeln('  }) {');
    buffer.writeln('    return $className(');

    // Return values: name: name ?? this.name,
    for (var p in params) {
      final fieldName = p.generatedConstructorVariable
          .replaceAll('required ', '')
          .replaceAll('this.', '')
          .replaceAll(',', '')
          .trim();
      buffer.writeln('      $fieldName: $fieldName ?? this.$fieldName,');
    }

    buffer.writeln('    );');
    buffer.writeln('  }');

    return buffer.toString();
  }

  /// Extracts variable name from generatedVariable:
  /// Example: "final String userName;" → "userName"
  // static String _extractFieldName(String generatedVariable) {
  //   // Remove "final", type, semicolon
  //   String cleaned = generatedVariable.trim();
  //   cleaned = cleaned.replaceAll("final ", "");
  //   cleaned = cleaned.replaceAll(";", "");

  //   // After removing type, last word is the field name
  //   return cleaned.split(" ").last;
  // }
}
