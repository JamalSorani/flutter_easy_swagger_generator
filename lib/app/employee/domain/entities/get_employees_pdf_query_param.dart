class GetEmployeesPdfQuery {
  final List<String> ids;

  GetEmployeesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
