class ModifyCurrencyExchangCommand {
  final String currency;
  final String currencypriceOne;
  final double priceone;
  final String currencypriceTwo;
  final double pricetwo;
  final String exchangetype;

  ModifyCurrencyExchangCommand({
    required this.currency,
    required this.currencypriceOne,
    required this.priceone,
    required this.currencypriceTwo,
    required this.pricetwo,
    required this.exchangetype,
  });
  Map<String, dynamic> toJson() {
    return {

      'currency': currency,
      'currencyPriceOne': currencypriceOne,
      'priceOne': priceone,
      'currencyPriceTwo': currencypriceTwo,
      'priceTwo': pricetwo,
      'exchangeType': exchangetype,
    };
  }

}
