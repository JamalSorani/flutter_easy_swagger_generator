class IRefProperty {
  final String ref;
  final String? type; // This is optional and can be null or omitted.

  IRefProperty(this.ref) : type = null;

  @override
  String toString() {
    return 'IRefProperty{ ref: $ref, type: $type }';
  }

  factory IRefProperty.fromJson(Map<String, dynamic> json) {
    return IRefProperty(json["\$ref"]);
  }
}
