
class MeasurementDeleteParam {
  final String id;
  MeasurementDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
