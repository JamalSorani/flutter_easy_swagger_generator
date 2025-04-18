
class MeasurementDeleteModel {
  final String id;
  final List<String> applicationjson;
  MeasurementDeleteModel({required this.id, required this.applicationjson});
  factory MeasurementDeleteModel.fromJson(Map<String, dynamic> json) {
    return MeasurementDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
