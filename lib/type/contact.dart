class Contact {
  final String name;

  Contact({required this.name});

  @override
  String toString() {
    return 'Contact{name: $name}';
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(name: json["name"]);
  }
}
