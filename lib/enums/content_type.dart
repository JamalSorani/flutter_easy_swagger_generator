/// Wrapper type representing supported media (content) types used in OpenAPI.
///
/// Provides named constants and a factory to map raw strings to a
/// strongly-typed value.
class TContentType {
  /// The raw media type string value (e.g., `application/json`).
  final String value;

  const TContentType._(this.value);

  /// `text/plain` content type.
  static const textPlain = TContentType._("text/plain");

  /// `application/json` content type.
  static const applicationJson = TContentType._("application/json");

  /// `text/json` content type.
  static const textJson = TContentType._("text/json");

  /// `multipart/form-data` content type.
  static const multipartFormData = TContentType._("multipart/form-data");

  /// Maps a raw media type [value] to a supported [TContentType].
  ///
  /// Falls back to [textPlain] for unrecognized values.
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
