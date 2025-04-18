class GetSalesWindowsPdfQueryParam {
  final List<String> ids;

  GetSalesWindowsPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
