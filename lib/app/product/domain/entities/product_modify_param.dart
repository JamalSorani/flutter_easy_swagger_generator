import 'activation_options_param.dart';
import 'modify_product_image_param.dart';
import 'inventory_status_param.dart';
import '../../../currencyexchange/domain/entities/currency_param.dart';

class ProductModifyParam {
  final String id;
  final String name;
  final String categoryId;
  final ActivationOptions status;
  final String description;
  final String notes;
  final List<ModifyProductImage> productImageDtos;
  final String productLicenseNumber;
  final String customsItemNumber;
  final List<String> customsMedias;
  final List<String> deleteCustomsMediasUrl;
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
  final String inventoryDate;
  final InventoryStatus inventoryStatus;
  final String labelContentContentOne;
  final String labelContentContentTwo;
  final String labelContentDescribtion;
  final Priority priority;
  final double weightOfOne;
  final double weightOfOneHundred;
  final double minimumQuantity;
  ProductModifyParam(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.status,
      required this.description,
      required this.notes,
      required this.productImageDtos,
      required this.productLicenseNumber,
      required this.customsItemNumber,
      required this.customsMedias,
      required this.deleteCustomsMediasUrl,
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
      required this.inventoryDate,
      required this.inventoryStatus,
      required this.labelContentContentOne,
      required this.labelContentContentTwo,
      required this.labelContentDescribtion,
      required this.priority,
      required this.weightOfOne,
      required this.weightOfOneHundred,
      required this.minimumQuantity});
}
