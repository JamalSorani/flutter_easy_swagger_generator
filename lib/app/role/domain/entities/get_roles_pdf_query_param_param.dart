class GetRolesPdfQueryParam {
  final List<String> ids;

  GetRolesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
