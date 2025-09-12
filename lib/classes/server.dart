class Server {
  /// The URL of the server
  final String url;

  /// Optional description of the server
  final String? description;

  Server({
    required this.url,
    this.description,
  });

  /// Creates a [Server] instance from a JSON map
  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      url: json['url'] as String,
      description: json['description'] as String?,
    );
  }

  /// Converts the [Server] instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if (description != null) 'description': description,
    };
  }
}
