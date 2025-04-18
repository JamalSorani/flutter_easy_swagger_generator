class GetProductsPdfQueryModel {
  final List<String> ids;

  GetProductsPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
