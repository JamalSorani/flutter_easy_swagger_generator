
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

      id: json["Id"] ,
      name: json["Name"] ,
      categoryId: json["CategoryId"] ,
      status: json["Status"] ,
      description: json["Description"] ,
      notes: json["Notes"] ,
      productImageDtos: json["ProductImageDtos"] ,
      productLicenseNumber: json["ProductLicenseNumber"] ,
      customsItemNumber: json["CustomsItemNumber"] ,
      customsMedias: json["CustomsMedias"] ,
      deleteCustomsMediasUrl: json["DeleteCustomsMediasUrl"] ,
      costPriceCurrency: json["CostPriceCurrency"] ,
      costPrice: json["CostPrice"] ,
      wholesalePriceCurrency: json["WholesalePriceCurrency"] ,
      wholesalePrice: json["WholesalePrice"] ,
      wholesalePriceType: json["WholesalePriceType"] ,
      consumerPriceCurrency: json["ConsumerPriceCurrency"] ,
      consumerPrice: json["ConsumerPrice"] ,
      offerPriceCurrency: json["OfferPriceCurrency"] ,
      offerPrice: json["OfferPrice"] ,
      shipmentNumber: json["ShipmentNumber"] ,
      shipmentDate: json["ShipmentDate"] ,
      measurementId: json["MeasurementId"] ,
      colorId: json["ColorId"] ,
      oreId: json["OreId"] ,
      sourceId: json["SourceId"] ,
      storeId: json["StoreId"] ,
      manufacturerId: json["ManufacturerId"] ,
      inventoryDate: json["InventoryDate"] ,
      inventoryStatus: json["InventoryStatus"] ,
      labelContentContentOne: json["LabelContent.ContentOne"] ,
      labelContentContentTwo: json["LabelContent.ContentTwo"] ,
      labelContentDescribtion: json["LabelContent.Describtion"] ,
      priority: json["Priority"] ,
      weightOfOne: json["WeightOfOne"] ,
      weightOfOneHundred: json["WeightOfOneHundred"] ,
      minimumQuantity: json["MinimumQuantity"] ,
    );
  }

}
