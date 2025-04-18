class GetOrdersPdfQueryParam {
  final List<String> ids;

  GetOrdersPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
