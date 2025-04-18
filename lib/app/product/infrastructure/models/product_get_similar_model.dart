
class ProductGetSimilarModel {
  final String image;
  final String selfId;
  ProductGetSimilarModel({required this.image, required this.selfId});
  factory ProductGetSimilarModel.fromJson(Map<String, dynamic> json) {
    return ProductGetSimilarModel(

      image: json["Image"] ,
      selfId: json["SelfId"] ,
    );
  }

}
