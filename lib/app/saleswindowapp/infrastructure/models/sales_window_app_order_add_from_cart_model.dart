
class SalesWindowAppOrderAddFromCartModel {
  final String shoppingCartId;
  final String customerId;
  final String phoneNumber;
  final String note;
  final List<String> files;
  SalesWindowAppOrderAddFromCartModel({required this.shoppingCartId, required this.customerId, required this.phoneNumber, required this.note, required this.files});
  factory SalesWindowAppOrderAddFromCartModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppOrderAddFromCartModel(

      'ShoppingCartId': shoppingCartId,
      'CustomerId': customerId,
      'PhoneNumber': phoneNumber,
      'Note': note,
      'Files': files,
    };
  }

}
