class UpsertColorCommandParam {
  final String id;
  final String name;
  final String tonality;

  UpsertColorCommandParam({
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
