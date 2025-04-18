class UpsertQuantityStyleCommand {
  final String id;
  final String name;

  UpsertQuantityStyleCommand({
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
