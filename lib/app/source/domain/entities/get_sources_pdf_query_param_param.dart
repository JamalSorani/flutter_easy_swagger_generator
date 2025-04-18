class GetSourcesPdfQueryParam {
  final List<String> ids;

  GetSourcesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
