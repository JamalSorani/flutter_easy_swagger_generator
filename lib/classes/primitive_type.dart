import 'number_type.dart';

class TPrimitiveType {
  final String? _stringValue;
  final TNumberType? _numberTypeValue;

  const TPrimitiveType._internal(this._stringValue) : _numberTypeValue = null;
  const TPrimitiveType.numberType(TNumberType type)
      : _numberTypeValue = type,
        _stringValue = null;

  // String primitive types
  static const TPrimitiveType boolean = TPrimitiveType._internal("boolean");
  static const TPrimitiveType string = TPrimitiveType._internal("string");

  @override
  String toString() {
    return _stringValue ?? _numberTypeValue?.toString() ?? '';
  }

  factory TPrimitiveType.fromJson(String? json) {
    switch (json) {
      case "boolean":
        return TPrimitiveType.boolean;
      case "string":
        return TPrimitiveType.string;
      case "integer":
        return const TPrimitiveType.numberType(TNumberType.integer);
      case "number":
        return const TPrimitiveType.numberType(TNumberType.number);
      default:
        return TPrimitiveType.string;
    }
  }
}
