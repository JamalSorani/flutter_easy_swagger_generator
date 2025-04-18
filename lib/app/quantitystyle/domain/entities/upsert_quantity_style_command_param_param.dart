class UpsertQuantityStyleCommandParam {
  final String id;
  final String name;

  UpsertQuantityStyleCommandParam({
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
