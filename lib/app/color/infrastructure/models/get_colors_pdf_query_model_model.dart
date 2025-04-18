class GetColorsPdfQueryModel {
  final List<String> ids;

  GetColorsPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
