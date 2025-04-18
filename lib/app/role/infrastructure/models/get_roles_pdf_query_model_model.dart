class GetRolesPdfQueryModel {
  final List<String> ids;

  GetRolesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
