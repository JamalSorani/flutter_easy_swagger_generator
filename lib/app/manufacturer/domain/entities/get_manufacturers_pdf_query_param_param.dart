class GetManufacturersPdfQueryParam {
  final List<String> ids;

  GetManufacturersPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
