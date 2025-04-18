import 'activation_options_param.dart';
import 'currency_param.dart';
import 'wholesale_price_type_param.dart';
import 'inventory_status_param.dart';
import 'priority_param.dart';
import 'upsert_product_stock_dto_param.dart';

class ProductAddParam {
  final String name;
  final String categoryId;
  final ActivationOptions status;
  final String description;
  final String notes;
  final List<String> productImages;
  final String productLicenseNumber;
  final String customsItemNumber;
  final List<String> customsMedias;
  final Currency costPriceCurrency;
  final double costPrice;
  final Currency wholesalePriceCurrency;
  final double wholesalePrice;
  final WholesalePriceType wholesalePriceType;
  final Currency consumerPriceCurrency;
  final double consumerPrice;
  final Currency offerPriceCurrency;
  final double offerPrice;
  final String shipmentNumber;
  final String shipmentDate;
  final String measurementId;
  final String colorId;
  final String oreId;
  final String sourceId;
  final String storeId;
  final String manufacturerId;
  final String iventoryDate;
  final InventoryStatus inventoryStatus;
  final String labelContentContentOne;
  final String labelContentContentTwo;
  final String labelContentDescribtion;
  final Priority priority;
  final double weightOfOne;
  final double weightOfOneHundred;
  final double minimumQuantity;
  final List<UpsertProductStockDto> productStockDtos;
  ProductAddParam(
      {required this.name,
      required this.categoryId,
      required this.status,
      required this.description,
      required this.notes,
      required this.productImages,
      required this.productLicenseNumber,
      required this.customsItemNumber,
      required this.customsMedias,
      required this.costPriceCurrency,
      required this.costPrice,
      required this.wholesalePriceCurrency,
      required this.wholesalePrice,
      required this.wholesalePriceType,
      required this.consumerPriceCurrency,
      required this.consumerPrice,
      required this.offerPriceCurrency,
      required this.offerPrice,
      required this.shipmentNumber,
      required this.shipmentDate,
      required this.measurementId,
      required this.colorId,
      required this.oreId,
      required this.sourceId,
      required this.storeId,
      required this.manufacturerId,
      required this.iventoryDate,
      required this.inventoryStatus,
      required this.labelContentContentOne,
      required this.labelContentContentTwo,
      required this.labelContentDescribtion,
      required this.priority,
      required this.weightOfOne,
      required this.weightOfOneHundred,
      required this.minimumQuantity,
      required this.productStockDtos});
}
