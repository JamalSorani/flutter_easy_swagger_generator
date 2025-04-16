// import '../helpers/dart_type.dart';
// import '../classes/dart_type_info.dart';
// import '../classes/parameter.dart';
// import '../classes/request_body.dart';
// import '../helpers/converters.dart';

// String generateRefClassContent(
//   String refSchema,
//   StringBuffer classBuffer,
//   List<IParameter>? parameters,
//   TRequestBody? requestBody,
// ) {
//   // Extract schema name from $ref
//   final ref = refSchema.split('/').last.split('.');
//   final schemaName = ref.last.toString().toLowerCase() == "request"
//       ? ref[ref.length - 2]
//       : ref.last;

//   classBuffer.writeln('class $schemaName {');

//   // Collecting parameter declarations and constructor parameters
//   List<String> parameterDeclarations = [];
//   List<String> requiredParams = [];
//   if (parameters != null) {
//     for (var param in parameters) {
//       String paramName = param.name;
//       if (paramName == 'X-TimeZoneId' ||
//           paramName == 'lang' ||
//           paramName == 'DebugMode') {
//         continue;
//       }
//       DartTypeInfo dartTypeInfo = getDartType(param.schema);
//       String paramType = dartTypeInfo.className;
//       if (paramName.contains(".")) {
//         paramName = paramName.replaceAll('.', '');
//       }
//       parameterDeclarations
//           .add('  final $paramType ${toCamelCase(paramName)};');
//       requiredParams.add('required this.${toCamelCase(paramName)}');
//     }
//   }
//   if (requestBody?.content != null) {
//     for (var prop in requestBody!.content!.keys) {
//       if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
//         continue;
//       }
//       DartTypeInfo dartTypeInfo =
//           getDartType(requestBody.content![prop]?.schema);
//       String propType = dartTypeInfo.className;
//       if (prop.contains(".")) {
//         prop = prop.replaceAll('.', '');
//       }
//       parameterDeclarations.add('  final $propType ${toCamelCase(prop)};');
//       requiredParams.add('required this.${toCamelCase(prop)}'); // Use lowercase
//     }
//   }

//   // Write parameter declarations
//   for (var declaration in parameterDeclarations) {
//     classBuffer.writeln(declaration);
//   }

//   // Adjust the constructor to handle empty classes
//   _generateConstructure(classBuffer, schemaName, requiredParams);
//   _generateToJson(classBuffer, parameters, requestBody);

//   classBuffer.writeln('}');
//   return classBuffer.toString();
// }

// _generateConstructure(
//     StringBuffer classBuffer, String className, List<String> requiredParams) {
//   if (requiredParams.isNotEmpty) {
//     classBuffer.write('  $className({');
//     classBuffer.write(requiredParams.join(', '));
//     classBuffer.writeln('});');
//   }
// }

// _generateToJson(
//   StringBuffer classBuffer,
//   List<IParameter>? parameters,
//   TRequestBody? requestBody,
// ) {
//   classBuffer.writeln('''
// Map<String, dynamic> toJson() {
//   return {
// ''');
//   if (parameters != null) {
//     for (var param in parameters) {
//       String paramName = param.name;
//       if (paramName == 'X-TimeZoneId' ||
//           paramName == 'lang' ||
//           paramName == 'DebugMode') {
//         continue;
//       }
//       final paramName2 = paramName.replaceAll(".", "");

//       classBuffer.writeln("    '$paramName': ${toCamelCase(paramName2)},");
//     }
//   }
//   if (requestBody?.content != null) {
//     for (var prop in requestBody!.content!.keys) {
//       if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
//         continue;
//       }
//       final prop2 = prop.replaceAll(".", "");
//       classBuffer.writeln("    '$prop': ${toCamelCase(prop2)},");
//     }
//   }
//   classBuffer.writeln('''
//   };
// }
// ''');
// }
