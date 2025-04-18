class GetCustomersPdfQuery {
  final List<String> ids;

  GetCustomersPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
