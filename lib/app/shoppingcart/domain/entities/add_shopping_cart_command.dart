class AddShoppingCartCommand {
  final String name;
  final dynamic productdtos;
  final dynamic packagedtos;

  AddShoppingCartCommand({
    required this.name,
    required this.productdtos,
    required this.packagedtos,
  });
  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'productDtos': productdtos,
      'packageDtos': packagedtos,
    };
  }

}
