
class PackageGetSimilarModel {
  final String packageId;
  PackageGetSimilarModel({required this.packageId});
  factory PackageGetSimilarModel.fromJson(Map<String, dynamic> json) {
    return PackageGetSimilarModel(

      'PackageId': packageId,
    };
  }

}
