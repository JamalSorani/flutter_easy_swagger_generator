class GetMeasurementsPdfQuery {
  final List<String> ids;

  GetMeasurementsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
