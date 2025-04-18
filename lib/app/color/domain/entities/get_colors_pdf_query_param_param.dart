class GetColorsPdfQueryParam {
  final List<String> ids;

  GetColorsPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
