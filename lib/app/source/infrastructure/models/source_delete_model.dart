
class SourceDeleteModel {
  final String id;
  final List<String> applicationjson;
  SourceDeleteModel({required this.id, required this.applicationjson});
  factory SourceDeleteModel.fromJson(Map<String, dynamic> json) {
    return SourceDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
