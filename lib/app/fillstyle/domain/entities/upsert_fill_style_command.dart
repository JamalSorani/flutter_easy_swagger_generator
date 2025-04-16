class UpsertFillStyleCommand {
  final String id;
  final String name;

  UpsertFillStyleCommand({
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
