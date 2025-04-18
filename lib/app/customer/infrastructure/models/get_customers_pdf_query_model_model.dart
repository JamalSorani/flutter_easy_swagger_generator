class GetCustomersPdfQueryModel {
  final List<String> ids;

  GetCustomersPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
