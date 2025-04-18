class GetSalesWindowsPdfQuery {
  final List<String> ids;

  GetSalesWindowsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
