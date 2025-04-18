class GetStoresPdfQuery {
  final List<String> ids;

  GetStoresPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
