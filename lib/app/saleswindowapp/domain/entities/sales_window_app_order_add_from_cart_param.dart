
class SalesWindowAppOrderAddFromCartParam {
  final String shoppingCartId;
  final String customerId;
  final String phoneNumber;
  final String note;
  final List<String> files;
  SalesWindowAppOrderAddFromCartParam({required this.shoppingCartId, required this.customerId, required this.phoneNumber, required this.note, required this.files});
  Map<String, dynamic> toJson() {
    return {

      'ShoppingCartId': shoppingCartId,
      'CustomerId': customerId,
      'PhoneNumber': phoneNumber,
      'Note': note,
      'Files': files,
    };
  }

}
