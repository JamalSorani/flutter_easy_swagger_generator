class GetRolesPdfQuery {
  final List<String> ids;

  GetRolesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
