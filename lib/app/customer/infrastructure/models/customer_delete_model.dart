
class CustomerDeleteModel {
  final String id;
  final List<String> applicationjson;
  CustomerDeleteModel({required this.id, required this.applicationjson});
  factory CustomerDeleteModel.fromJson(Map<String, dynamic> json) {
    return CustomerDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
