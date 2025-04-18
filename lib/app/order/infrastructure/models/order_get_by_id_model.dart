
class OrderGetByIdModel {
  final String id;
  OrderGetByIdModel({required this.id});
  factory OrderGetByIdModel.fromJson(Map<String, dynamic> json) {
    return OrderGetByIdModel(

      id: json["Id"] ,
    );
  }

}
