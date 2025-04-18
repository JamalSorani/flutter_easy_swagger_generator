class GetStoresPdfQueryParam {
  final List<String> ids;

  GetStoresPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
