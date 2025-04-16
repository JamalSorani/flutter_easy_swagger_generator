class UpsertStoreCommand {
  final String id;
  final String name;

  UpsertStoreCommand({
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
