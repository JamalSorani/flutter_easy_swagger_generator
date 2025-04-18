class UpsertStoreCommandModel {
  final String id;
  final String name;

  UpsertStoreCommandModel({
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
