class GetStoresPdfQueryModel {
  final List<String> ids;

  GetStoresPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
