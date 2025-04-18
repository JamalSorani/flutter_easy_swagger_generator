
class SalesWindowGetByIdModel {
  final String id;
  SalesWindowGetByIdModel({required this.id});
  factory SalesWindowGetByIdModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowGetByIdModel(

      id: json["Id"] ,
    );
  }

}
