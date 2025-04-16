
class WarehouseGetByIdParam {
  final String id;
  WarehouseGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
