class GetColorsPdfQuery {
  final dynamic ids;

  GetColorsPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
