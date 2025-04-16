class GetPackagesPdfQuery {
  final dynamic ids;

  GetPackagesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
