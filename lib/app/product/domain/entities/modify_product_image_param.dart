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
  Map<String, dynamic> toJson() {
    return {

      'url': url,
      'image': image,
      'order': order,
      'action': action,
    };
  }

}
