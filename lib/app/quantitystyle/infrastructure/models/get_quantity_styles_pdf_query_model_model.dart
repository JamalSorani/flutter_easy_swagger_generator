class GetQuantityStylesPdfQueryModel {
  final List<String> ids;

  GetQuantityStylesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
