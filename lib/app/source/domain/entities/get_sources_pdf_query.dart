class GetSourcesPdfQuery {
  final dynamic ids;

  GetSourcesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
