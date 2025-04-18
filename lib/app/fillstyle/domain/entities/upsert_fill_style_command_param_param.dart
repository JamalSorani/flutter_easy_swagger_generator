class UpsertFillStyleCommandParam {
  final String id;
  final String name;

  UpsertFillStyleCommandParam({
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
