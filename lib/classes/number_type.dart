enum TNumberType {
  integer("integer"),
  number("number");

  final String value;

  const TNumberType(this.value);

  factory TNumberType.fromJson(String json) {
    switch (json) {
      case "integer":
        return TNumberType.integer;
      case "number":
        return TNumberType.number;
      default:
        return TNumberType.number;
    }
  }
}
