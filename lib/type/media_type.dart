enum TMediaType {
  multipartFormData("multipart/form-data"),
  applicationJson("application/json"),
  textPlain("text/plain"),
  textJson("text/json"),
  applicationPlusJson("application/*+json");

  final String value;

  const TMediaType(this.value);

  @override
  String toString() => value;
}
