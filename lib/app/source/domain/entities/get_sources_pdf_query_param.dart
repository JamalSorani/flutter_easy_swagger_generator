class GetSourcesPdfQuery {
  final List<String> ids;

  GetSourcesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
