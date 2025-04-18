
class PackageGetByIdModel {
  final String id;
  final String search;
  PackageGetByIdModel({required this.id, required this.search});
  factory PackageGetByIdModel.fromJson(Map<String, dynamic> json) {
    return PackageGetByIdModel(

      'Id': id,
      'Search': search,
    };
  }

}
