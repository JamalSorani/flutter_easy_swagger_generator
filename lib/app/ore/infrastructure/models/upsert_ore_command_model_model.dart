class UpsertOreCommandModel {
  final String id;
  final String name;

  UpsertOreCommandModel({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
    };
  }

}
