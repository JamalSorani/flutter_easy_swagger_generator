class UpsertFillStyleCommandModel {
  final String id;
  final String name;

  UpsertFillStyleCommandModel({
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
