/// Supported HTTP methods recognized by the code generator and runtime.
///
/// These values map directly from OpenAPI path method keys (e.g., `get`, `post`).
enum HttpMethodType {
  /// HTTP GET: retrieve data without side effects.
  get,

  /// HTTP POST: create or submit data to the server.
  post,

  /// HTTP DELETE: delete resources on the server.
  delete,

  /// HTTP PUT: replace an existing resource with the provided payload.
  put,
}
