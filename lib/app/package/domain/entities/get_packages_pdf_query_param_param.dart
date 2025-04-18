class GetPackagesPdfQueryParam {
  final List<String> ids;

  GetPackagesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
