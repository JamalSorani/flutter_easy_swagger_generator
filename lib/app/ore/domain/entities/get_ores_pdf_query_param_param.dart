class GetOresPdfQueryParam {
  final List<String> ids;

  GetOresPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
