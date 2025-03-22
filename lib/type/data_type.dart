import 'primitive_type.dart';

class TDataType {
  final String? _stringValue;
  final TPrimitiveType? _primitiveTypeValue;

  const TDataType._internal(this._stringValue) : _primitiveTypeValue = null;
  const TDataType.primitiveType(TPrimitiveType type)
      : _primitiveTypeValue = type,
        _stringValue = null;

  // String data types
  static const TDataType array = TDataType._internal("array");
  static const TDataType object = TDataType._internal("object");

  @override
  String toString() {
    return _stringValue ?? _primitiveTypeValue?.toString() ?? '';
  }
}
