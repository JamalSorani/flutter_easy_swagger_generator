class GetOrdersPdfQueryModel {
  final List<String> ids;

  GetOrdersPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
