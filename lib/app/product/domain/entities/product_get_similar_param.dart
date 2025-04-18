
class ProductGetSimilarParam {
  final String image;
  final String selfId;
  ProductGetSimilarParam({required this.image, required this.selfId});
  Map<String, dynamic> toJson() {
    return {

      'Image': image,
      'SelfId': selfId,
    };
  }

}
