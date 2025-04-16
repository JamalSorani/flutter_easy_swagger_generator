class GetMeasurementsPdfQuery {
  final dynamic ids;

  GetMeasurementsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
