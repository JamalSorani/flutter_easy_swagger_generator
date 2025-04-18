class GetColorsPdfQuery {
  final List<String> ids;

  GetColorsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
