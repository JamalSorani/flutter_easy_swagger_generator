class UpsertQuantityStyleCommandModel {
  final String id;
  final String name;

  UpsertQuantityStyleCommandModel({
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
