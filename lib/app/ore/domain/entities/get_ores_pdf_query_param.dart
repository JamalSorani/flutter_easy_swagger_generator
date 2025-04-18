class GetOresPdfQuery {
  final List<String> ids;

  GetOresPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
