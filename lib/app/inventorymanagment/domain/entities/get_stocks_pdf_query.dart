class GetStocksPdfQuery {
  final dynamic ids;

  GetStocksPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
