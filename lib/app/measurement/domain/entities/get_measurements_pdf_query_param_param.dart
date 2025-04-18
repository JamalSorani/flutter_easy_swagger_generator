class GetMeasurementsPdfQueryParam {
  final List<String> ids;

  GetMeasurementsPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
