class DartTypeInfo {
  final String className;
  final dynamic schema;
  final bool isRef;

  DartTypeInfo(
      {required this.className, required this.schema, this.isRef = false});
}
