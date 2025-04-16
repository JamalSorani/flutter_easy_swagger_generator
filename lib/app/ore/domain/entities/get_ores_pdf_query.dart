class GetOresPdfQuery {
  final dynamic ids;

  GetOresPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
