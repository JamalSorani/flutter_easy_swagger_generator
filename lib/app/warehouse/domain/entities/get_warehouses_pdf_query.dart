class GetWarehousesPdfQuery {
  final dynamic ids;

  GetWarehousesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
