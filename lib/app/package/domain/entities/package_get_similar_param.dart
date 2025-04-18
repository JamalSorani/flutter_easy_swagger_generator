
class PackageGetSimilarParam {
  final String packageId;
  PackageGetSimilarParam({required this.packageId});
  Map<String, dynamic> toJson() {
    return {

      'PackageId': packageId,
    };
  }

}
