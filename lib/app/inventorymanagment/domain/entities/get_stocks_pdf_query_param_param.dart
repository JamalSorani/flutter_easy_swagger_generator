class GetStocksPdfQueryParam {
  final List<String> ids;

  GetStocksPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
