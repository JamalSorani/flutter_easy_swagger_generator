
class EmployeeDeleteParam {
  final String id;
  EmployeeDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
