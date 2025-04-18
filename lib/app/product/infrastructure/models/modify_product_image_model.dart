class ModifyProductImage {
  final String url;
  final String image;
  final int order;
  final String action;

  ModifyProductImage({
    required this.url,
    required this.image,
    required this.order,
    required this.action,
  });
  factory ModifyProductImage.fromJson(Map<String,dynamic>json){
  return ModifyProductImage(

      url : json["url"],
      image : json["image"],
      order : json["order"],
      action : json["action"],
    );
  }

}
