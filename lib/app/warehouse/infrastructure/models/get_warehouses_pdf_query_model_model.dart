class GetWarehousesPdfQueryModel {
  final List<String> ids;

  GetWarehousesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
