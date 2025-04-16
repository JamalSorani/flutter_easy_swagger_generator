class ModifyShoppingCartCommand {
  final String shoppingcartId;
  final String name;
  final dynamic productdtos;
  final dynamic packagedto;

  ModifyShoppingCartCommand({
    required this.shoppingcartId,
    required this.name,
    required this.productdtos,
    required this.packagedto,
  });
  Map<String, dynamic> toJson() {
    return {

      'shoppingCartId': shoppingcartId,
      'name': name,
      'productDtos': productdtos,
      'packageDto': packagedto,
    };
  }

}
