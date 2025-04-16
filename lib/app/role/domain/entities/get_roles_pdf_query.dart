class GetRolesPdfQuery {
  final dynamic ids;

  GetRolesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
