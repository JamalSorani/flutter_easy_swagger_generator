class GetManufacturersPdfQuery {
  final dynamic ids;

  GetManufacturersPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
