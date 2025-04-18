
class EmployeeGetByIdParam {
  final String id;
  EmployeeGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
