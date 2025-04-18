class UpsertStoreCommandParam {
  final String id;
  final String name;

  UpsertStoreCommandParam({
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
