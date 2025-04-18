class GetStocksPdfQueryModel {
  final List<String> ids;

  GetStocksPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
