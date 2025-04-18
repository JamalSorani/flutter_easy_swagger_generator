class GetEmployeesPdfQueryParam {
  final List<String> ids;

  GetEmployeesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
