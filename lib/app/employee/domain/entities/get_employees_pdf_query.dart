class GetEmployeesPdfQuery {
  final dynamic ids;

  GetEmployeesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
