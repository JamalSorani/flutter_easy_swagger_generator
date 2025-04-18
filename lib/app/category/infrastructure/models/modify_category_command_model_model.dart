class ModifyCategoryCommandModel {
  final String id;
  final String name;
  final String code;
  final String description;
  final String status;

  ModifyCategoryCommandModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.status,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'status': status,
    };
  }

}
