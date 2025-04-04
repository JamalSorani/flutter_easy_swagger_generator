String generateRefClassContent(String refSchema, StringBuffer classBuffer) {
  // Extract schema name from $ref
  final ref = refSchema.split('/').last.split('.');
  final schemaName = ref.last.toString().toLowerCase() == "request"
      ? ref[ref.length - 2]
      : ref.last;

  classBuffer.writeln('class $schemaName {');

  classBuffer.writeln('}');
  return classBuffer.toString();
}
