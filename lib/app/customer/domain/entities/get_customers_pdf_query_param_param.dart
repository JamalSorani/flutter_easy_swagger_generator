class GetCustomersPdfQueryParam {
  final List<String> ids;

  GetCustomersPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
