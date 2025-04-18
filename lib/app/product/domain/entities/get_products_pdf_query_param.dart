class GetProductsPdfQuery {
  final List<String> ids;

  GetProductsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
