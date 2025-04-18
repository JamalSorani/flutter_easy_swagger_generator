class ModifyCurrencyExchangCommandModel {
  final String currency;
  final String currencypriceOne;
  final double priceone;
  final String currencypriceTwo;
  final double pricetwo;
  final String exchangetype;

  ModifyCurrencyExchangCommandModel({
    required this.currency,
    required this.currencypriceOne,
    required this.priceone,
    required this.currencypriceTwo,
    required this.pricetwo,
    required this.exchangetype,
  });
  factory ModifyCurrencyExchangCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyCurrencyExchangCommandModel(

      currency : json["currency"],
      currencypriceOne : json["currencyPriceOne"],
      priceone : json["priceOne"],
      currencypriceTwo : json["currencyPriceTwo"],
      pricetwo : json["priceTwo"],
      exchangetype : json["exchangeType"],
    );
  }

}
