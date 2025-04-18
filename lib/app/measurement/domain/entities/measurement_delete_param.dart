
class MeasurementDeleteParam {
  final String id;
  final List<String> applicationjson;
  MeasurementDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
