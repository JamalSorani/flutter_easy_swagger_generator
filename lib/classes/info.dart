import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

import 'contact.dart';

/// Represents the metadata information of an API.
class Info {
  /// The title of the API.
  final String title;

  /// A brief description of the API.
  final String description;

  /// The version of the API.
  final String version;

  /// Optional contact information for the API.
  final Contact? contact;

  /// Constructs an [Info] object with required fields and optional [contact].
  Info({
    required this.title,
    required this.description,
    required this.version,
    required this.contact,
  });

  /// Creates an [Info] instance from a JSON map.
  ///
  /// Parses the `contact` field into a [Contact] object if it exists.
  factory Info.fromJson(Map<String, dynamic> json) {
    printMap("The metadata information of an API:", json);
    return Info(
      title: json['title'] as String,
      description: json['description'] as String,
      version: json['version'] as String,
      contact:
          json['contact'] != null ? Contact.fromJson(json['contact']) : null,
    );
  }
}

/*Example:

  "info": {
    "title": "DAN.API Mobile - In Staging",
    "description": "Published at 09/04/2025 08:42:23",
    "version": "v1"
  },
*/
