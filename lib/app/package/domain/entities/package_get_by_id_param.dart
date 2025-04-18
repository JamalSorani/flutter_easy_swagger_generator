
class PackageGetByIdParam {
  final String id;
  final String search;
  PackageGetByIdParam({required this.id, required this.search});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'Search': search,
    };
  }

}
