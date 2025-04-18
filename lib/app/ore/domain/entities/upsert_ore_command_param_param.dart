class UpsertOreCommandParam {
  final String id;
  final String name;

  UpsertOreCommandParam({
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
