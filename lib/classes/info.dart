import 'contact.dart';

class Info {
  final String title;
  final String description;
  final String version;
  final Contact? contact;

  Info({
    required this.title,
    required this.description,
    required this.version,
    required this.contact,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'] as String,
      description: json['description'] as String,
      version: json['version'] as String,
      contact:
          json['contact'] != null ? Contact.fromJson(json['contact']) : null,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'description': description,
  //     'version': version,
  //     'contact': contact.toJson(),
  //   };
  // }
}
