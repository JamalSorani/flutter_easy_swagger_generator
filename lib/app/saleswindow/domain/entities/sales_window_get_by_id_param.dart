
class SalesWindowGetByIdParam {
  final String id;
  SalesWindowGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
