class UpsertOreCommand {
  final String id;
  final String name;

  UpsertOreCommand({
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
