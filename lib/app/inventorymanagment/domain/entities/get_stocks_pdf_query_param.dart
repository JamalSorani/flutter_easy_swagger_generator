class GetStocksPdfQuery {
  final List<String> ids;

  GetStocksPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
