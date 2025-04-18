
class WarehouseGetByIdModel {
  final String id;
  WarehouseGetByIdModel({required this.id});
  factory WarehouseGetByIdModel.fromJson(Map<String, dynamic> json) {
    return WarehouseGetByIdModel(

      id: json["Id"] ,
    );
  }

}
