/// Represents the type of a numeric value in a schema.
enum TNumberType {
  /// Represents an integer value.
  integer("integer"),

  /// Represents a floating-point or decimal number.
  number("number");

  /// The string value associated with the enum.
  final String value;

  /// Const constructor to associate a string value with the enum.
  const TNumberType(this.value);

  /// Creates a [TNumberType] from a JSON string.
  ///
  /// Defaults to [TNumberType.number] if the string does not match "integer" or "number".
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
