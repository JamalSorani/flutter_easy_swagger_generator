import '../classes/components.dart';
import '../classes/dart_type_info.dart';
import '../classes/parameter.dart';
import '../classes/request_body.dart';
import '../helpers/converters.dart';
import '../helpers/dart_type.dart';

class ClassSerializerGenerator {
  final StringBuffer classBuffer;
  final String className;
  final Components components;

  ClassSerializerGenerator({
    required this.classBuffer,
    required this.className,
    required this.components,
  });

  generateConstructure(List<String> requiredParams) {
    if (requiredParams.isNotEmpty) {
      classBuffer.write('  $className({');
      classBuffer.write(requiredParams.join(', '));
      classBuffer.writeln('});');
    }
  }

  genereateToJson(
    List<IParameter>? parameters,
    TRequestBody? requestBody,
  ) {
    bool isWritingStarted = false;
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        String camelCaseName = toCamelCase(paramName.replaceAll('.', ''));
        if (!isWritingStarted) {
          classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
          isWritingStarted = true;
        }
        classBuffer.writeln('      \'$paramName\': $camelCaseName,');
      }
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        bool isRef = false;
        if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
          if (requestBody.content![prop]?.schema?.ref == null) {
            continue;
          } else {
            if (prop == "application/json") {
              isRef = true;
            } else {
              continue;
            }
          }
        }
        if (isRef) {
          DartTypeInfo dartTypeInfo =
              getDartType(requestBody.content![prop]?.schema, components);
          String propType = dartTypeInfo.className;

          classBuffer.write('''
 Map<String, dynamic> toJson() {
    return
          ${toCamelCase(propType)}.toJson();
          }    
        }
          ''');
          return;
        } else {
          String camelCaseName = toCamelCase(prop.replaceAll('.', ''));
          classBuffer.writeln('      \'$prop\': $camelCaseName,');
        }
      }
    }
    if (isWritingStarted) {
      classBuffer.writeln('''
    };
  }
''');
    }

    classBuffer.writeln('}');
  }
}
