class Contact {
  final String? name;

  Contact({required this.name});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(name: json["name"]);
  }
}
