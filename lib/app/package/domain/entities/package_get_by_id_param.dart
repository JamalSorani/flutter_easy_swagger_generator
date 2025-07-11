class PackageGetByIdParam {
  final String id;
  PackageGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
