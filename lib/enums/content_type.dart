class TContentType {
  final String value;

  const TContentType._(this.value);

  static const textPlain = TContentType._("text/plain");
  static const applicationJson = TContentType._("application/json");
  static const textJson = TContentType._("text/json");
  static const multipartFormData = TContentType._("multipart/form-data");

  factory TContentType.fromString(String value) {
    switch (value) {
      case "text/plain":
        return textPlain;
      case "application/json":
        return applicationJson;
      case "text/json":
        return textJson;
      case "multipart/form-data":
        return multipartFormData;
      default:
        return textPlain;
    }
  }
}
