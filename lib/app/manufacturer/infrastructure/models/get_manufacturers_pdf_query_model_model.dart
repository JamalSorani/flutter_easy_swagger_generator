class GetManufacturersPdfQueryModel {
  final List<String> ids;

  GetManufacturersPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
