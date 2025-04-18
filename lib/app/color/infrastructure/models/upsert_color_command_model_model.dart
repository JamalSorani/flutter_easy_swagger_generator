class UpsertColorCommandModel {
  final String id;
  final String name;
  final String tonality;

  UpsertColorCommandModel({
    required this.id,
    required this.name,
    required this.tonality,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'tonality': tonality,
    };
  }

}
