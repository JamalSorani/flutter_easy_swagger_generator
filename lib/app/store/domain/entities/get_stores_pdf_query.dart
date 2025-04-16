class GetStoresPdfQuery {
  final dynamic ids;

  GetStoresPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
