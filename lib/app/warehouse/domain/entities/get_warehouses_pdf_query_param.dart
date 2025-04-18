class GetWarehousesPdfQuery {
  final List<String> ids;

  GetWarehousesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
