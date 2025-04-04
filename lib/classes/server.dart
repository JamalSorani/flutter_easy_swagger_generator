class Server {
  final String url;
  final String? description;

  Server({
    required this.url,
    required this.description,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      url: json["url"],
      description: json["description"],
    );
  }
}
