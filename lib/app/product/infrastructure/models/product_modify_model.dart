
import 'activation_options_model_model.dart';
import 'modify_product_image_model.dart';
import 'currency_model_model.dart';
import 'currency_model_model.dart';
import 'wholesale_price_type_model_model.dart';
import 'currency_model_model.dart';
import 'currency_model_model.dart';
import 'inventory_status_model_model.dart';
import 'priority_model_model.dart';
class ProductModifyModel {
  final String id;
  final String name;
  final String categoryId;
  final ActivationOptionsModel status;
  final String description;
  final String notes;
  final List<ModifyProductImage> productImageDtos;
  final String productLicenseNumber;
  final String customsItemNumber;
  final List<String> customsMedias;
  final List<String> deleteCustomsMediasUrl;
  final CurrencyModel costPriceCurrency;
  final double costPrice;
  final CurrencyModel wholesalePriceCurrency;
  final double wholesalePrice;
  final WholesalePriceTypeModel wholesalePriceType;
  final CurrencyModel consumerPriceCurrency;
  final double consumerPrice;
  final CurrencyModel offerPriceCurrency;
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
  final InventoryStatusModel inventoryStatus;
  final String labelContentContentOne;
  final String labelContentContentTwo;
  final String labelContentDescribtion;
  final PriorityModel priority;
  final double weightOfOne;
  final double weightOfOneHundred;
  final double minimumQuantity;
  ProductModifyModel({required this.id, required this.name, required this.categoryId, required this.status, required this.description, required this.notes, required this.productImageDtos, required this.productLicenseNumber, required this.customsItemNumber, required this.customsMedias, required this.deleteCustomsMediasUrl, required this.costPriceCurrency, required this.costPrice, required this.wholesalePriceCurrency, required this.wholesalePrice, required this.wholesalePriceType, required this.consumerPriceCurrency, required this.consumerPrice, required this.offerPriceCurrency, required this.offerPrice, required this.shipmentNumber, required this.shipmentDate, required this.measurementId, required this.colorId, required this.oreId, required this.sourceId, required this.storeId, required this.manufacturerId, required this.inventoryDate, required this.inventoryStatus, required this.labelContentContentOne, required this.labelContentContentTwo, required this.labelContentDescribtion, required this.priority, required this.weightOfOne, required this.weightOfOneHundred, required this.minimumQuantity});
  factory ProductModifyModel.fromJson(Map<String, dynamic> json) {
    return ProductModifyModel(

      'Id': id,
      'Name': name,
      'CategoryId': categoryId,
      'Status': status,
      'Description': description,
      'Notes': notes,
      'ProductImageDtos': productImageDtos,
      'ProductLicenseNumber': productLicenseNumber,
      'CustomsItemNumber': customsItemNumber,
      'CustomsMedias': customsMedias,
      'DeleteCustomsMediasUrl': deleteCustomsMediasUrl,
      'CostPriceCurrency': costPriceCurrency,
      'CostPrice': costPrice,
      'WholesalePriceCurrency': wholesalePriceCurrency,
      'WholesalePrice': wholesalePrice,
      'WholesalePriceType': wholesalePriceType,
      'ConsumerPriceCurrency': consumerPriceCurrency,
      'ConsumerPrice': consumerPrice,
      'OfferPriceCurrency': offerPriceCurrency,
      'OfferPrice': offerPrice,
      'ShipmentNumber': shipmentNumber,
      'ShipmentDate': shipmentDate,
      'MeasurementId': measurementId,
      'ColorId': colorId,
      'OreId': oreId,
      'SourceId': sourceId,
      'StoreId': storeId,
      'ManufacturerId': manufacturerId,
      'InventoryDate': inventoryDate,
      'InventoryStatus': inventoryStatus,
      'LabelContent.ContentOne': labelContentContentOne,
      'LabelContent.ContentTwo': labelContentContentTwo,
      'LabelContent.Describtion': labelContentDescribtion,
      'Priority': priority,
      'WeightOfOne': weightOfOne,
      'WeightOfOneHundred': weightOfOneHundred,
      'MinimumQuantity': minimumQuantity,
    };
  }

}
