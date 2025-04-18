
class OreDeleteModel {
  final String id;
  final List<String> applicationjson;
  OreDeleteModel({required this.id, required this.applicationjson});
  factory OreDeleteModel.fromJson(Map<String, dynamic> json) {
    return OreDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
