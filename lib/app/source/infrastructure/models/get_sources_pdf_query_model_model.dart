class GetSourcesPdfQueryModel {
  final List<String> ids;

  GetSourcesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
