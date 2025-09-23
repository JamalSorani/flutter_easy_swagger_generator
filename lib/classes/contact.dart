import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class Contact {
  final String? name;

  Contact({required this.name});

  factory Contact.fromJson(Map<String, dynamic> json) {
    printMap("Contact information for the API:", json);
    return Contact(name: json["name"]);
  }
}
