
class CustomerGetByIdParam {
  final String id;
  CustomerGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
