class GetQuantityStylesPdfQuery {
  final List<String> ids;

  GetQuantityStylesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
