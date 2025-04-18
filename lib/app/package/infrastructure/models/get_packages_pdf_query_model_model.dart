class GetPackagesPdfQueryModel {
  final List<String> ids;

  GetPackagesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
