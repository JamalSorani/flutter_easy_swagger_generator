class GetPackagesPdfQuery {
  final List<String> ids;

  GetPackagesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
