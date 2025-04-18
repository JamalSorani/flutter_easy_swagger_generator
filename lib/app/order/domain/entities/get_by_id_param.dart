
class OrderGetByIdParam {
  final String id;
  OrderGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
