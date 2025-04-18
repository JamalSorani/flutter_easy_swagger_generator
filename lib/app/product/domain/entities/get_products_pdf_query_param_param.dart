class GetProductsPdfQueryParam {
  final List<String> ids;

  GetProductsPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
