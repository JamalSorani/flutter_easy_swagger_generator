class GetOresPdfQueryModel {
  final List<String> ids;

  GetOresPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
