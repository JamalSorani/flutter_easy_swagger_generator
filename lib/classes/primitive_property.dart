import 'primitive_type.dart';

class IPrimitiveProperty {
  final TPrimitiveType type;

  const IPrimitiveProperty(this.type);

  @override
  String toString() {
    return 'IPrimitiveProperty{ type: $type }';
  }

  factory IPrimitiveProperty.fromJson(Map<String, dynamic> json) {
    return IPrimitiveProperty(
      TPrimitiveType.fromJson(json["type"]),
    );
  }
}
