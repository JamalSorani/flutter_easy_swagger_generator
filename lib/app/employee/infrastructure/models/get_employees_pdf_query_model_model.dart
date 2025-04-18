class GetEmployeesPdfQueryModel {
  final List<String> ids;

  GetEmployeesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
