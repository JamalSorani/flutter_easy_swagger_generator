class UpsertMeasurementCommand {
  final String id;
  final String name;
  final String description;

  UpsertMeasurementCommand({
    required this.id,
    required this.name,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'description': description,
    };
  }

}
