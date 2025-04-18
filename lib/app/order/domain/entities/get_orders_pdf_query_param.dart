class GetOrdersPdfQuery {
  final List<String> ids;

  GetOrdersPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
