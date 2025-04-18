class GetSalesWindowsPdfQueryModel {
  final List<String> ids;

  GetSalesWindowsPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
