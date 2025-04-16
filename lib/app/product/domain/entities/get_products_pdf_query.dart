class GetProductsPdfQuery {
  final dynamic ids;

  GetProductsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
