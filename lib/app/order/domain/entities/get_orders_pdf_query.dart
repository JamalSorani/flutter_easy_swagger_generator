class GetOrdersPdfQuery {
  final dynamic ids;

  GetOrdersPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
