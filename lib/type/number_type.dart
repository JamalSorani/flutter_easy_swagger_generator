enum TNumberType {
  integer("integer"),
  number("number");

  final String value;

  const TNumberType(this.value);

  @override
  String toString() => value;
}
