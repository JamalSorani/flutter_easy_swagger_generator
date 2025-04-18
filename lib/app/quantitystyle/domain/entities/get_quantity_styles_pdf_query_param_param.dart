class GetQuantityStylesPdfQueryParam {
  final List<String> ids;

  GetQuantityStylesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
