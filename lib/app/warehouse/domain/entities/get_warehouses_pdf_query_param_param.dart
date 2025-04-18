class GetWarehousesPdfQueryParam {
  final List<String> ids;

  GetWarehousesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
