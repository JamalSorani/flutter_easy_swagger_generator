class GetManufacturersPdfQuery {
  final List<String> ids;

  GetManufacturersPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
