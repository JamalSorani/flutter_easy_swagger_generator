
class FillStyleDeleteModel {
  final String id;
  final List<String> applicationjson;
  FillStyleDeleteModel({required this.id, required this.applicationjson});
  factory FillStyleDeleteModel.fromJson(Map<String, dynamic> json) {
    return FillStyleDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
