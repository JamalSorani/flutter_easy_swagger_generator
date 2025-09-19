import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Represents contact information for the API.
class Contact {
  /// The name of the contact person or organization.
  final String? name;

  /// Constructs a [Contact] instance with an optional [name].
  Contact({required this.name});

  /// Creates a [Contact] instance from a JSON map.
  factory Contact.fromJson(Map<String, dynamic> json) {
    printMap("Contact information for the API:", json);
    return Contact(name: json["name"]);
  }
}
