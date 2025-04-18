class GetMeasurementsPdfQueryModel {
  final List<String> ids;

  GetMeasurementsPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
