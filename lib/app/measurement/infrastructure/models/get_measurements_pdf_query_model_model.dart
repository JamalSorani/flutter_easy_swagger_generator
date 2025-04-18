class GetMeasurementsPdfQueryModel {
  final List<String> ids;

  GetMeasurementsPdfQueryModel({
    required this.ids,
  });
  factory GetMeasurementsPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetMeasurementsPdfQueryModel(

      ids : json["ids"],
    );
  }

}
