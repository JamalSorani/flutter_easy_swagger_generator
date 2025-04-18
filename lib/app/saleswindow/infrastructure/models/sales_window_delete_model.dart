
class SalesWindowDeleteModel {
  final String id;
  final List<String> applicationjson;
  SalesWindowDeleteModel({required this.id, required this.applicationjson});
  factory SalesWindowDeleteModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
