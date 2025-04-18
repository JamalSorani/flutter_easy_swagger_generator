
class EmployeeDeleteParam {
  final String id;
  final List<String> applicationjson;
  EmployeeDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
